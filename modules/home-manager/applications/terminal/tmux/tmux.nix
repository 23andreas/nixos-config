{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

let
  tmuxIsEnabled = config.programs.tmux.enable;
in
{
  options.nixosConfig.shell.tmux = {
    enable = lib.mkEnableOption "Enable Tmux";
  };

  config = lib.mkIf tmuxIsEnabled {
    home.packages = [ pkgs.tmux-sessionizer ];
    programs.tmux = {
      keyMode = "vi";
      clock24 = true;
      mouse = true;
      newSession = false;
      prefix = "C-a";
      terminal = "tmux-256color";
      extraConfig = ''

        # Show hide status bar
        bind-key b set-option status
        # Tms
        bind o display-popup -E "tms"

        bind j join-pane -v
        bind J join-pane 

        set-option -g status-interval 5
        # set-option -g automatic-rename on
        # set-option -g automatic-rename-format '#{b:pane_current_command} (#{b:pane_current_path})'

        # vim-tmux-naviator plug related stuff
        # Smart pane switching with awareness of Vim splits.
        # See: https://github.com/christoomey/vim-tmux-navigator 
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l
        # end

        # Start windows and panes at 1, not 0
        set -g base-index 1
        setw -g pane-base-index 1
        # Auto renumber windows on close
        set -g renumber-windows on

        # image.nvim 
        set -gq allow-passthrough on
        set -g visual-activity off

        set-option -ga terminal-overrides ",xterm-256color:Tc"

        set -s copy-command 'wl-copy'
        bind P paste-buffer
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi V send-keys -X rectangle-toggle
        unbind -T copy-mode-vi Enter
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
        bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'wl-copy'
        bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'wl-copy'

        # Make tmux set the terminal/window title to the session name
        set -g set-titles on
        set -g set-titles-string '#{pane_current_command} (#{session_name})'
      '';
      plugins = with pkgs; [
        tmuxPlugins.sensible
        {
          plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
          extraConfig = ''
            # set -g @minimal-tmux-indicator false
            set -g @minimal-tmux-indicator-str "  #S  "
            # set -g @minimal-tmux-status-left-extra "  #S  "

            set -g @minimal-tmux-justify "left"
            set -g @minimal-tmux-status "top"
            set -g @minimal-tmux-right false
          '';
        }
        # tmuxPlugins.notify
        # tmuxPlugins.tmux-window-name
        # {
        #   plugin = tmuxPlugins.resurrect;
        #   extraConfig = ''
        #     set -g @resurrect-strategy-nvim 'session'
        #     set -g @resurrect-capture-pane-contents 'on'
        #     set -g @resurrect-processes 'lazygit'
        #   '';
        # }
        # {
        # plugin = tmuxPlugins.catppuccin;
        # extraConfig = ''
        #   set -g @catppuccin_window_default_text '#{b:pane_current_command} (#{b:pane_current_path})'
        # '';
        # }
        # {
        #   plugin = tmuxPlugins.continuum;
        #   extraConfig = ''
        #     set -g @continuum-restore 'on'
        #   '';
        # }
      ];
    };
  };
}
