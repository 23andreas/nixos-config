{ pkgs, ... }:

{
  services = {
    xserver.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
      };
    };

    desktopManager.plasma6.enable = true;
  };

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
  };

  environment.systemPackages = with pkgs.kdePackages; [
    merkuro
    korganizer
    kcolorchooser
    sddm-kcm
    kompare
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    baloo-widgets
    elisa
    kate
    khelpcenter
    konsole
    krdp
  ];

  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    # "app-org.kde.kalendarac@autostart".enable = false;
  };
}
