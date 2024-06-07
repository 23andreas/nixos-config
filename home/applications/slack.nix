{ config, lib, pkgs, ... }:

let
  cfg = config.nixosConfig.app.slack;
in
{
  options.nixosConfig.app.slack = {
    enable = lib.mkEnableOption "Slack";
    enableWaylandFix = lib.mkEnableOption  "adds --use-gl=desktop launch option";
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkMerge [
      (lib.mkIf (!cfg.enableWaylandFix) [
        pkgs.slack
      ])
      (lib.mkIf cfg.enableWaylandFix [
        (pkgs.writeShellApplication {
          name = "slack";
          text = "${pkgs.slack}/bin/slack --use-gl=desktop";
        })
        (pkgs.makeDesktopItem {
          name = "slack";
          exec = "slack";
          desktopName = "Slack";
          icon = "${pkgs.slack}/share/pixmaps/slack.png";
        })
      ])
    ];
  };
}
