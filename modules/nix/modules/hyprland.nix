# https://github.com/sjcobb2022/nixos-config/blob/main/hosts/common/optional/greetd.nix
{ pkgs, ... }:

# let
#   tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
# in
{
  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # TODO move this
  # services.greetd = {
  #   enable = false;
  #   settings = {
  #     default_session = {
  #       command = "${tuigreet} --time --remember uwsm start hyprland-uwsm.desktop";
  #       user = "greeter";
  #     };
  #   };
  # };
  #
  # systemd.services.greetd.serviceConfig = {
  #   Type = "idle";
  #   StandardInput = "tty";
  #   StandardOutput = "tty";
  #   StandardError = "journal"; # Without this errors will spam on screen
  #   # Without these bootlogs will spam on screen
  #   TTYReset = true;
  #   TTYVHangup = true;
  #   TTYVTDisallocate = true;
  # };

  environment.systemPackages = [
    pkgs.hyprland-qtutils
  ];

  environment.variables = {
    # ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    # xdgOpenUsePortal = true;
    # extraPortals = with pkgs; [
    # xdg-desktop-portal-hyprland
    # kdePackages.xdg-desktop-portal-kde
    # xdg-desktop-portal-gtk
    # ];
  };
}
