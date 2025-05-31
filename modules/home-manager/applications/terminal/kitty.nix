{ config, lib, ... }:

let
  kittyEnabled = config.programs.kitty.enable;
in
{
  config = lib.mkIf kittyEnabled {
    home.sessionVariables.TERMINAL = "kitty";

    catppuccin.kitty = {
      enable = true;
      # flavor = "macchiato";
    };

    programs.kitty = {
      shellIntegration.enableFishIntegration = true;
      settings = {
        # window_padding_width = 4;
        confirm_os_window_close = 0;
        placement_strategy = "top";
        # background = "#1d2129";
        # background = "#151B23";
        # background = "#1F2733";
        # background_opacity = "0.97";
        # background_blur = 60;
        font_size = "10.8";
        # modify_font = "cell_height 110%";

        cursor_trail = 1;
        cursor_trail_decay = "0.1 0.3";
      };
    };
  };
}
