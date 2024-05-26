{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #Discord workaround for wayland
    (writeShellApplication {
       name = "discord";
       text = "${pkgs.discord}/bin/discord --use-gl=desktop";
    })

    (makeDesktopItem {
      name = "discord";
      exec = "discord";
      desktopName = "Discord";
      icon = "${pkgs.discord}/share/pixmaps/discord.png";
    })
  ];
}

