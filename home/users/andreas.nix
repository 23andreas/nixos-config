{ config, ... }:
{
  home.username = "andreas";
  home.homeDirectory = "/home/andreas";
  home.stateVersion = "23.11";

  imports = [
    ../applications
    ../shell
    ../profiles
    ../fonts.nix

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
        IdentityFile ~/.ssh/id_ed25519
        IdentityAgent ~/.1password/agent.sock
    '';
  };
  services.ssh-agent.enable = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  services.playerctld.enable = true;

  home = {
    file."${config.home.homeDirectory}/Pictures/Wallpapers" = {
      source = ../../resources/wallpapers;
      recursive = true;
    };
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

      EDITOR = "vim";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
