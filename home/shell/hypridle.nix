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
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          # Screen off
          # {
          #   timeout = 180;
          #   on-timeout = "hyprctl dispatch dpms off";
          #   on-resume = "hyprctl dispatch dpms on";
          # }

          # Lockscreen
          {
            timeout = 240;
            on-timeout = "loginctl lock-session";
          }

          # Suspend
          {
            timeout = 480;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
