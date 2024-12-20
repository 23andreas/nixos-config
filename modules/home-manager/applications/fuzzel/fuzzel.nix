{ config, lib, ... }:
let
  cfg = config.nixosConfig.app.fuzzel;
in
{
  options.nixosConfig.app.fuzzel = {
    enable = lib.mkEnableOption "fuzzel";
  };

  config = lib.mkIf cfg.enable {

    catppuccin.fuzzel.enable = true;

    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          inner-pad = 2;
        };
        colors = {
          # 0.8 opacity
          # background = "1f2733cc";
          # 0.9 opacity
          background = "1f2733e6";
          text = "cdd6f4ff";
          match = "89b4faff";
          selection = "585b70ff";
          selection-match = "89b4faff";
          selection-text = "cdd6f4ff";
          border = "b4befeff";
        };
        border = {
          width = 0;
          radius = 0;
        };
      };
    };

    home.file.".local/share/powermenu.sh" = {
      source = ./powermenu.sh;
      executable = true;
    };

    home.file.".local/share/recordmenu.sh" = {
      source = ./recordmenu.sh;
      executable = true;
    };
  };
}
