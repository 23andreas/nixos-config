{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "slack";
      text = "${pkgs.slack}/bin/slack --use-gl=desktop";
    })

    (makeDesktopItem {
      name = "slack";
      exec = "slack";
      desktopName = "Slack";
      icon = "${pkgs.slack}/share/pixmaps/slack.png";
    })
  ];
}

