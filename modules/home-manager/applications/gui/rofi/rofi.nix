{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.programs.rofi.enable {
    catppuccin.rofi.enable = false;

    home.packages = with pkgs; [
      rofimoji
      rofi-calc
      wtype # Rofimoji uses it for typing
      rofi-rbw-wayland
    ];

    programs.rofi = {
      # enable = true;
      terminal = "${pkgs.kitty}/bin/kitty";
      plugins = [
        pkgs.rofi-calc
      ];
      extraConfig = {
        run-command = "uwsm app -- {cmd}";
      };
      theme = ./themes/main.rasi;
    };

    xdg.configFile."rofi/main.rasi" = {
      source = ./themes/main.rasi;
    };

    xdg.configFile."rofi/menu.rasi" = {
      source = ./themes/menu.rasi;
    };

    xdg.configFile."rofi/ssh.rasi" = {
      source = ./themes/ssh.rasi;
    };

    xdg.configFile."rofi/cliphist.rasi" = {
      source = ./themes/cliphist.rasi;
    };

    xdg.configFile."rofi/rofimoji.rasi" = {
      source = ./themes/rofimoji.rasi;
    };

    xdg.configFile."rofi/rbw.rasi" = {
      source = ./themes/rbw.rasi;
    };

    xdg.configFile."rofi/powermenu.rasi" = {
      source = ./themes/powermenu.rasi;
    };

    xdg.configFile."rofi/recordmenu.rasi" = {
      source = ./themes/recordmenu.rasi;
    };

    home.file.".local/bin/powermenu.sh" = {
      source = ./powermenu.sh;
      executable = true;
    };

    home.file.".local/share/recordmenu.sh" = {
      source = ./recordmenu.sh;
      executable = true;
    };
  };
}
