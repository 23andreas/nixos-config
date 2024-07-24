{ config, lib, pkgs, ... }:

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
      extraConfig = ''
        resurrect_dir="$HOME/.tmux/resurrect"
        set -g @resurrect-dir $resurrect_dir
        set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/home/$USER/.nix-profile/bin/||g" $target | sponge $target'

        set-option -g status-interval 5
        set-option -g automatic-rename on
        set-option -g automatic-rename-format '#{b:pane_current_command} (#{b:pane_current_path})'
      '';
      plugins = with pkgs; [
        tmuxPlugins.sensible
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
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin_window_default_text '#{b:pane_current_command} (#{b:pane_current_path})'
          '';
        }
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

