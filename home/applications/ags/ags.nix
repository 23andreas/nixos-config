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
      pkgs.sassc
    ];

    nixosConfig.shell.gtk.enable = true;

    # Symlink ags config folder when testing out changes
    # xdg.configFile.ags.source = config.lib.file.mkOutOfStoreSymlink "/home/andreas/nixos/home/applications/ags/config";

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
