{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nixosConfig.app.vscode;
in
{
  options.nixosConfig.app.vscode = {
    enable = lib.mkEnableOption "Vscode";
    enableWaylandFix = lib.mkEnableOption "enable wayland fix";
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkMerge [
      (lib.mkIf (!cfg.enableWaylandFix) [
        (pkgs.writeShellApplication {
          name = "vscode";
          text = "${pkgs.vscode}/bin/code --password-store=gnome-libsecret";
        })

        (pkgs.makeDesktopItem {
          name = "vscode";
          exec = "vscode";
          desktopName = "Visual Studio Code";
          icon = "${pkgs.vscode}/share/pixmaps/vscode.png";
        })
      ])

      (lib.mkIf cfg.enableWaylandFix [
        (pkgs.writeShellApplication {
          name = "vscode";
          text = "${pkgs.vscode}/bin/code --ozone-platform=wayland --password-store=gnome-libsecret";
        })

        (pkgs.makeDesktopItem {
          name = "vscode";
          exec = "vscode";
          desktopName = "Visual Studio Code";
          icon = "${pkgs.vscode}/share/pixmaps/vscode.png";
        })
      ])
    ];
  };
}
