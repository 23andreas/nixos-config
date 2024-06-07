{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.nixosConfig.app.ags;
in
{
  options.nixosConfig.app.ags = {
    enable = lib.mkEnableOption "Ags";
  };

  imports = [
    inputs.ags.homeManagerModules.default
  ];

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.bun
    ];
    nixosConfig.shell.gtk.enable = true;

    programs.ags = {
      enable = true;
      configDir = ./config;
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
  };
}
