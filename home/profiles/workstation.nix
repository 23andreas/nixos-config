{ config, lib, pkgs, ... }:

let
  cfg = config.nixosConfig.profiles.workstation;
in
{
  options.nixosConfig.profiles.workstation =
    {
      enable = lib.mkEnableOption "Enable workstation profile";
    };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian

      mpv

      firefox
      google-chrome
      czkawka
    ];

    nixosConfig = {
      app = {
        ags.enable = true;
        anyrun.enable = true;
        kitty.enable = true;

        spotify = {
          enable = true;
          enableWaylandFix = true;
        };

        slack = {
          enable = true;
          enableWaylandFix = true;
        };
      };
      shell = {
        hyprland.enable = true;
        hyprpaper = {
          enable = true;
          wallpaperPath = builtins.toPath ../../resources/wallpapers/30.png;
        };
        hyprlock = {
          enable = true;
          backgroundPath = builtins.toPath ../../resources/wallpapers/30.png;
        };
        hypridle.enable = true;
      };
    };
  };
}
