{ pkgs, ... }:

{
  dconf.settings = {
    # "org/gnome/desktop/background" = {
    #   picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    # };
    "org/gnome/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  # Wayland, X, etc. support for session vars
  # systemd.user.sessionVariables = config.home-manager.users.justinas.home.sessionVariables;
  qt = {
    enable = true;
    # platformTheme = "gnome";
    # style = {
    #   name = "adwaita";
    #   # package = pkgs.qt6Packages.qtstyleplugin-adwaita;
    # };
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";
      package = pkgs.qt6Packages.qtstyleplugin-kvantum;
    };
  };
}
