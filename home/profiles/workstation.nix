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
          wallpaperPath = builtins.toPath ../../resources/wallpapers/1308922.jpg;
        };
      };
    };
  };
}
