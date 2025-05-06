{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.nixosConfig.profiles.workstation;
in
{
  options.nixosConfig.profiles.workstation = {
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
      # inputs.zen-browser.packages."${system}".default
      koodo-reader
    ];

    programs.chromium = {
      enable = true;
      package = pkgs.brave;
    };

    programs.firefox = {
      enable = true;
      package = pkgs.firefox.override {
        nativeMessagingHosts = [
          pkgs.tridactyl-native
        ];
      };
    };
    
    # Workaround for
    # https://github.com/catppuccin/nix/issues/552
    catppuccin.mako.enable = false;

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
          wallpaperPath = "${config.home.homeDirectory}/Pictures/Wallpapers/mountain-upscaled.jpeg";
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
