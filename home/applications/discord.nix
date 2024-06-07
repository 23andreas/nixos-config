{ config, lib, pkgs, ... }:

let
  cfg = config.nixosConfig.app.discord;
in
{
  options.nixosConfig.app.discord = {
    enable = lib.mkEnableOption "Discord";
    enableWaylandFix = lib.mkEnableOption "Enable wayland fix";
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkMerge [
      (lib.mkIf (!cfg.enableWaylandFix) [
        pkgs.spotify
      ])
      (lib.mkIf cfg.enableWaylandFix [
        (pkgs.writeShellApplication {
          name = "discord";
          text = "${pkgs.discord}/bin/discord --use-gl=desktop";
        })

        (pkgs.makeDesktopItem {
          name = "discord";
          exec = "discord";
          desktopName = "Discord";
          icon = "${pkgs.discord}/share/pixmaps/discord.png";
        })
      ])
    ];
  };
}
