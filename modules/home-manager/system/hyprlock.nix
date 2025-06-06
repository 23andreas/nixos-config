{ lib, config, ... }:

{
  config = lib.mkIf config.programs.hyprlock.enable {
    catppuccin.hyprlock.enable = false;
    programs.hyprlock = {
      settings = {
        background = {
          # NOTE wallpaper configured in wallpaper.nix
          monitor = "";
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };

        general = {
          no_fade_in = false;
          grace = 0;
          disable_loading_bar = true;
        };

        input-field = [
          {
            monitor = "";
            size = "250, 60";
            outline_thickness = 2;
            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            outer_color = "rgba(25, 23, 36, 0)";
            inner_color = "rgba(255, 255, 255, 0.4)";
            font_color = "rgb(0, 0, 0)";
            fade_on_empty = true;
            rounding = 5;
            font_family = "SFProText Nerd Font";
            placeholder_text = "";
            hide_input = false;
            position = "0, -120";
            halign = "center";
            valign = "center";
          }
        ];

        # TIME
        label = [
          {
            monitor = "";
            text = ''
              cmd[update:1000] echo "$(date +"%H:%M")"
            '';
            # color = "$foreground";
            color = "rgb(255, 255, 255)";
            font_size = "120";
            font_family = "SFProText Nerd Font";
            position = "0, -300";
            halign = "center";
            valign = "top";
          }
        ];
      };
    };
  };
}
