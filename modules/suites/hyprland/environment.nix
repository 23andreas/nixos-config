{
  home = {
    sessionVariables = {
      EDITOR = "vim";
      TERMINAL = "kitty";

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
}

