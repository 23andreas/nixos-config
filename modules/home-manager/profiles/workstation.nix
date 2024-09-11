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

      # firefox
      google-chrome
      czkawka # find duplicate files

      todoist-electron
    ];

    programs.firefox = {
      enable = true;
      package = pkgs.firefox.override {
        nativeMessagingHosts = [
          pkgs.tridactyl-native
        ];
      };
    };

    nixosConfig = {
      app = {
        waybar.enable = true;
        swaync.enable = true;
        walker.enable = true;
        kitty = {
          enable = true;
          isDefaultTerminal = true;
        };

        fuzzel.enable = true;

        spotify = {
          enable = true;
        };

        slack = {
          enable = true;
          enableWaylandFix = false;
        };
      };
      shell = {
        hyprland.enable = true;
        gtk.enable = true;
        avizo.enable = true;
        hyprpaper = {
          enable = true;
          wallpaperPath = "${config.home.homeDirectory}/Pictures/Wallpapers/mountain.jpg";
        };
        hyprlock = {
          enable = true;
          backgroundPath = "${config.home.homeDirectory}/Pictures/Wallpapers/green_leaves_3.jpg";
        };
        hypridle.enable = true;
      };
    };
  };
}
