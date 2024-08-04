{ config, lib, pkgs, inputs, ... }:

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

      # firefox
      google-chrome
      czkawka # find duplicate files

      todoist-electron

      inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    home.sessionVariables.HYPRCURSOR_THEME = "McMojave";
    home.sessionVariables.HYPRCURSOR_SIZE = "22";

    nixosConfig = {
      app = {
        ags.enable = true;
        # waybar.enable = true;
        swaync.enable = true;

        anyrun.enable = true;
        # walker.enable = true;
        kitty.enable = true;

        spotify = {
          enable = true;
          enableWaylandFix = true;
        };

        spotify-player.enable = true;

        slack = {
          enable = true;
          enableWaylandFix = false;
        };
      };
      shell = {
        hyprland.enable = true;
        hyprpaper = {
          enable = true;
          wallpaperPath = "${config.home.homeDirectory}/Pictures/Wallpapers/30.png";
        };
        hyprlock = {
          enable = true;
          backgroundPath = "${config.home.homeDirectory}/Pictures/Wallpapers/30.png";
        };
        hypridle.enable = true;
      };
    };
  };
}
