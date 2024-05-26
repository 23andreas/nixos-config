{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #Vscode workaround for wayland
    (writeShellApplication {
      name = "spotify";
      text = "${pkgs.spotify}/bin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland ";
    })

    (makeDesktopItem {
      name = "spotify";
      exec = "spotify";
      desktopName = "Spotify";
      icon = "${pkgs.spotify}/share/icons/hicolor/64x64/apps/spotify-client.png";
    })
  ];
}

