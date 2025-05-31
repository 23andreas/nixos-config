{ pkgs, ... }:

{
  services = {
    xserver.enable = true;
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };

    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dconf-editor
    # gnomeExtensions.forge
    gnomeExtensions.pop-shell
    gnomeExtensions.pano
    gnomeExtensions.caffeine
    gnomeExtensions.just-perfection
  ];

  environment.gnome.excludePackages = with pkgs; [
    geary
    totem
    epiphany
    yelp

    gnome-contacts
    gnome-maps
    gnome-music

    gnome-tour
    gnome-user-docs
  ];
}
