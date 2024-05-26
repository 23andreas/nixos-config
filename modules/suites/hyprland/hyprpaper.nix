{ config, inputs, pkgs, ... }:

{
  home.packages = [
    inputs.hyprpaper.packages.${pkgs.system}.hyprpaper
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${/. + ../../../resources/wallpapers/24.webp}
    wallpaper = ,${/. + ../../../resources/wallpapers/24.webp}
    ipc = off
  '';
}

