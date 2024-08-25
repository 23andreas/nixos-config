{ lib, config, inputs, pkgs, ... }:

let
  cfg = config.nixosConfig.shell.hyprpaper;
in
{
  options.nixosConfig.shell.hyprpaper = {
    enable = lib.mkEnableOption "Hyprpaper";
    wallpaperPath = lib.mkOption {
      type = lib.types.path;
      default = null;
      description = "Path to the wallpaper file";
    };
  };

  config = lib.mkIf cfg.enable
    {
      assertions = [
        {
          assertion = cfg.wallpaperPath != null;
          message = "Missing wallpaperPath";
        }
      ];

      home.packages = [
        inputs.hyprpaper.packages.${pkgs.system}.hyprpaper
      ];

      home.file.".config/hypr/hyprpaper.conf".text = ''
        preload = ${cfg.wallpaperPath}
        wallpaper = ,${cfg.wallpaperPath}
        ipc = on
      '';
    };
}
