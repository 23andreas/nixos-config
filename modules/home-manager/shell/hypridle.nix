{ lib, config, ... }:

let
  cfg = config.nixosConfig.shell.hypridle;
in
{
  options.nixosConfig.shell.hypridle = {
    enable = lib.mkEnableOption "hypridle";
  };

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "gnome-screensaver-command -l";
          before_sleep_cmd = "gnome-screensaver-command -l";
          # after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          # Screen off
          # {
          #   timeout = 300;
          #   on-timeout = "hyprctl dispatch dpms off";
          #   on-resume = "hyprctl dispatch dpms on";
          # }

          # Lockscreen
          {
            timeout = 620;
            on-timeout = "loginctl lock-session";
          }

          # Suspend
          {
            timeout = 600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
