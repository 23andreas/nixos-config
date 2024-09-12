  { config, lib, pkgs, ... }:

  let
    cfg = config.nixosConfig.app.swaync;
  in
  {
    options.nixosConfig.app.swaync = {
      enable = lib.mkEnableOption "Swaync";
    };

    config = lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        swaynotificationcenter
        # playing notification sound
        sox
      ];

      home.file.".config/swaync/sound.sh" = {
        source = ./sound.sh;
        executable = true;
      };

      home.file.".config/swaync/moon_drop.mp3" = {
        source = ./moon_drop.mp3;
      };

      xdg.configFile."swaync/style.css".source = ./style.css;
      xdg.configFile."swaync/config.json".source = ./config.json;
    };
  }
