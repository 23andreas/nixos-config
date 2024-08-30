{ config, lib, ... }:
let
  cfg = config.nixosConfig.app.kitty;
in
{
  options.nixosConfig.app.kitty = {
    enable = lib.mkEnableOption "Kitty";
    isDefaultTerminal = lib.mkOption {
      default = true;
      description = "Set Kitty as default terminal";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.TERMINAL = lib.mkIf cfg.isDefaultTerminal "kitty";

    programs.kitty = {
      enable = true;
      # catppuccin = {
      #   enable = true;
      #   flavor = "macchiato";
      # };

      settings = {
        # window_padding_width = 4;
        confirm_os_window_close = 0;
        # background_opacity = "0.9";
        # background_blur = 60;
        font_size = 11;
        # modify_font = "cell_height 110%";
      };
    };
  };
}
