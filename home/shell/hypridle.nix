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
        };

        listener = [
          # Lockscreen
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }

          # Screen off
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
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
