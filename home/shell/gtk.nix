{ config, lib, pkgs, ... }:
let
  cfg = config.nixosConfig.shell.gtk;
in
{
  options.nixosConfig.shell.gtk = {
    enable = lib.mkEnableOption "GTK";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.gtk3
    ];

    gtk = lib.mkIf cfg.enable {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };
  };
}
