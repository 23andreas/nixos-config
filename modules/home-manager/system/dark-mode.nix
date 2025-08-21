{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.home.darkMode;
in
{
  options.home.darkMode = {
    enable = lib.mkEnableOption "Enable dark mode";
  };

  config = lib.mkIf cfg.enable {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita-dark";
        color-scheme = "prefer-dark";
      };
    };

    gtk = lib.mkIf config.gtk.enable {
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      # theme = lib.mkDefault {
      #   name = "adw-gtk3-dark";
      #   package = pkgs.adw-gtk3;
      # };
    };

    qt = lib.mkIf config.qt.enable {
      platformTheme.name = "kvantum";
      style = {
        name = "kvantum";
        package = pkgs.qt6Packages.qtstyleplugin-kvantum;
      };
    };
  };
}
