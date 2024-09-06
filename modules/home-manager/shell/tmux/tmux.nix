{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.nixosConfig.shell.tmux;
in
{
  options.nixosConfig.shell.tmux = {
    enable = lib.mkEnableOption "Enable Tmux";
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      keyMode = "vi";
      clock24 = true;
      mouse = true;
      newSession = false;
      prefix = "C-Space";
      terminal = "screen-256color";
      extraConfig = ''
        bind -n C-Space set status on \;\
          switch-client -T prefix \;\
          run-shell -d 1 -b "while [ $(tmux display-message -p '##{client_prefix}') -eq 1 ]; do sleep 0.5; done; tmux set status off"

        resurrect_dir="$HOME/.tmux/resurrect"
        set -g @resurrect-dir $resurrect_dir
        set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/home/$USER/.nix-profile/bin/||g" $target | sponge $target'

        set-option -g status-interval 5
        # set-option -g automatic-rename on
        # set-option -g automatic-rename-format '#{b:pane_current_command} (#{b:pane_current_path})'
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
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-processes 'lazygit'
          '';
        }
        # {
          # plugin = tmuxPlugins.catppuccin;
          # extraConfig = ''
          #   set -g @catppuccin_window_default_text '#{b:pane_current_command} (#{b:pane_current_path})'
          # '';
        # }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
          '';
        }
      ];
    };
  };
}

