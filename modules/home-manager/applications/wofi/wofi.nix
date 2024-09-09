{ config, lib, ... }:
let
  cfg = config.nixosConfig.app.wofi;
in
{
  options.nixosConfig.app.wofi = {
    enable = lib.mkEnableOption "wofi";
  };

  config = lib.mkIf cfg.enable {

    programs.wofi = {
      enable = true;
    };

    home.file.".local/share/powermenu.sh" = {
      source = ./powermenu.sh;
      executable = true;
    };
  };
}
