{ ... }:

{
  home.username = "andreas";
  home.homeDirectory = "/home/andreas";
  home.stateVersion = "23.11";

  imports = [
    ../applications
    ../shell
    ../profiles

    ../../system/modules/system/fonts.nix
    ../../system/modules/system/terminal.nix
  ];

  nixosConfig.profiles = {
    development.enable = true;
    leisure.enable = true;
    screen-capture.enable = true;
    utils.enable = true;
    workstation.enable = true;
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';
  };

  services.playerctld.enable = true;

  home = {
    sessionVariables = {
      #Electron
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";

      # OpenGL variable refresh rate
      __GL_VRR_ALLOWED = "1";

      # Wayland
      CLUTTER_BACKEND = "wayland";

      # Hardware acceleration
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
