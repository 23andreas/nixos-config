{ config, lib, pkgs, ... }:

let
  cfg = config.nixosConfig.app.spotify;
in
{
  options.nixosConfig.app.spotify = {
    enable = lib.mkEnableOption "Spotify";
    enableWaylandFix = lib.mkEnableOption "Enable wayland fix";
  };

  config = {
    home.packages = lib.mkMerge [
      (lib.mkIf (!cfg.enableWaylandFix) [
        pkgs.spotify
      ])
      (lib.mkIf cfg.enableWaylandFix [
        (pkgs.writeShellApplication {
          name = "spotify";
          text = "${pkgs.spotify}/bin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland ";
        })
        (pkgs.makeDesktopItem {
          name = "spotify";
          exec = "spotify";
          desktopName = "Spotify";
          icon = "${pkgs.spotify}/share/icons/hicolor/64x64/apps/spotify-client.png";
        })
      ])
    ];
  };
}
