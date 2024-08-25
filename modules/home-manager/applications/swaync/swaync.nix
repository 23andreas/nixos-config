  { config, lib, pkgs, ... }:

  let
    cfg = config.nixosConfig.app.swaync;
  in
  {
    options.nixosConfig.app.swaync = {
      enable = lib.mkEnableOption "Swaync";
    };

    config = lib.mkIf cfg.enable {
      home.packages = (with pkgs; [ swaynotificationcenter ]);
      xdg.configFile."swaync/style.css".source = ./style.css;
      xdg.configFile."swaync/config.json".source = ./config.json;
    };
  }
