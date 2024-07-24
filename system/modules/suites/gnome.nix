{ config, lib, pkgs, ... }:

let
  defaultExcludePackages = [
    pkgs.gnome-tour
    pkgs.cheese
    pkgs.gnome.gnome-music
    pkgs.gnome.gnome-clocks
    pkgs.gnome.gnome-maps
    pkgs.gnome-calculator
    pkgs.simple-scan
    pkgs.epiphany
    pkgs.geary
    pkgs.totem
    pkgs.gnome.gnome-contacts
    pkgs.yelp
  ];

  cfg = config.suites.gnome;
in
{
  options.suites.gnome = {
    enable = lib.mkEnableOption "enable gnome";
    enablePaperWM = lib.mkEnableOption "enable paperWM";
    excludePackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = defaultExcludePackages;
      description = "List of GNOME packages to exclude";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # enable keyring
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true; # keyring graphical frontend
    security.pam.services.gdm.enableGnomeKeyring = true; # load gnome-keyring at startup
    environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";

    environment.gnome.excludePackages = config.suites.gnome.excludePackages;
    environment.systemPackages = lib.mkIf cfg.enablePaperWM [
      pkgs.gnomeExtensions.paperwm
    ];

    programs.dconf.profiles.user.databases = lib.mkIf cfg.enablePaperWM [{
      settings = with lib.gvariant; {

        "org/gnome/shell".enabled-extensions =
          [
            "paperwm@paperwm.github.com"
          ];

        "org/gnome/shell/extensions/paperwm".cycle-height-steps = "[0.25, 0.5, 0.75]";
        "org/gnome/shell/extensions/paperwm".cycle-width-steps = "[0.25, 0.5, 0.75]";

        "org/gnome/shell/extensions/paperwm".horizontal-margin = "0";
        "org/gnome/shell/extensions/paperwm".vertical-margin-bottom = "5";
        "org/gnome/shell/extensions/paperwm".vertical-margin = "5";
        "org/gnome/shell/extensions/paperwm".window-gap = mkInt32 20;

        "org/gnome/shell/extensions/paperwm".window-switcher-preview-scale = "0.15";

        "org/gnome/shell/extensions/paperwm".use-default-background = "1";

        "org/gnome/shell/extensions/paperwm/keybindings".switch-left = "['<Super>h']";
        "org/gnome/shell/extensions/paperwm/keybindings".switch-right = "['<Super>l']";

        "org/gnome/settings-daemon/plugins/media-keys".screensaver = "disabled";
      };
    }];
  };
}

