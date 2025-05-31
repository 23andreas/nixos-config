{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./settings.nix
    ./keybindings.nix
    ./monitors.nix
  ];

  config = lib.mkIf config.wayland.windowManager.hyprland.enable {

    # used for processing hyprctl json output in keybindings
    programs.jq.enable = true;

    home.packages = with pkgs; [
      wl-clipboard
    ];

    home.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      CLUTTER_BACKEND = "wayland";
    };

    xdg.configFile."xdg-desktop-portal-hyprland" = {
      text = ''
        screencopy {
          allow-token-by_default = true;
        }
      '';
      target = "hypr/xdph.conf";
    };
  };
}
