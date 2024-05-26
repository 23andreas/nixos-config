{ inputs, pkgs, ... }:

{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    gtk3
    bun
  ];

  gtk = {
    enable = true;
  };

  programs.ags = {
    enable = true;
    configDir = ./config;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
}

