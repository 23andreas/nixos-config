{ lib, config, ... }:

{
  config.services.hypridle.settings = lib.mkIf config.services.hypridle.enable {
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
}
