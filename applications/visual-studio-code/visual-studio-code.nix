{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #Vscode workaround for wayland
    (writeShellApplication {
      name = "vscode";
      text = "${pkgs.vscode}/bin/code --ozone-platform=wayland --password-store=gnome-libsecret";
    })

    (makeDesktopItem {
      name = "vscode";
      exec = "vscode";
      desktopName = "Visual Studio Code";
      icon = "${pkgs.vscode}/share/pixmaps/vscode.png";
    })
  ];
}

