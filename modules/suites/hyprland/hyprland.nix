{ pkgs, ... }:

{
  imports = [
    ./environment.nix
    ./keybindings.nix
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      monitor=DP-4,3440x1440@60,auto,auto
      monitor=Unknown-1,disable
      # monitor=,preferred,auto,auto
    '';

    settings = {
      general = {

        gaps_in = 2;
        gaps_out = 4;
        border_size = 3;

        "col.active_border" = "rgb(d62828)";
        "col.inactive_border" = "0x00000000";

        border_part_of_window = false;
        no_border_on_floating = false;
      };

      master = {
        no_gaps_when_only = 1;
      };

      dwindle = {
        no_gaps_when_only = 1;
      };

      animations = {
        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];

        animation = [
          "windowsIn, 1, 3, easeOutCubic, popin 30%" # window open
          "windowsOut, 1, 3, fluent_decel, popin 70%" # window close.
          "windowsMove, 1, 2, easeinoutsine, slide" # everything in between, moving, dragging, resizing.

          "windowsIn, 1, 3, easeOutCubic, popin 30%"
          "specialWorkspace,1,5,default,slidefadevert"
        ];
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      input = {
        numlock_by_default = true;
      };

      exec-once = [
        "hash dbus-update-activation-environment 2>/dev/null &"
        "dbus-update-activation-environment --systemd &"
        "ags -b hyprland &"
        "hyprpaper &"
      ];
    };
  };
}

