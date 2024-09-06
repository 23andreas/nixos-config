{ config, lib, ... }:
let
  cfg = config.nixosConfig.app.kitty;
in
{
  options.nixosConfig.app.kitty = {
    enable = lib.mkEnableOption "Kitty";
    isDefaultTerminal = lib.mkOption {
      default = false;
      description = "Set Kitty as default terminal";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.TERMINAL = lib.mkIf cfg.isDefaultTerminal "kitty";

    programs.kitty = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      settings = {
        # window_padding_width = 4;
        bonfirm_os_window_close = 0;
        placement_strategy = "top";
        # background = "#1d2129";
        # background = "#151B23";
        background = "#1F2733";
        # background_opacity = "0.95";
        # background_blur = 60;
        font_size = "10.8";
        # modify_font = "cell_height 110%";
      };
    };
  };
}
