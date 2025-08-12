{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../presets
    ../presets/workstation.nix
    ../applications
  ];

  catppuccin = {
    enable = true;
    accent = "blue";
    flavor = "macchiato";
  };

  wayland.windowManager.hyprland.enable = true;
  wallpaper.path = "${config.home.homeDirectory}/Pictures/Wallpapers/0040.jpg";

  programs.fish.enable = true;

  programs = {
    aichat.enable = true;
    atuin.enable = true;
    git.enable = true;
    hyprlock.enable = true;
    kitty.enable = true;
    mpv.enable = true;
    neovim.enable = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    rbw.enable = true;
    rofi.enable = true;
    ssh = {
      enable = true;
      extraConfig = ''
        Host *
          IdentityFile ~/.ssh/id_ed25519
      '';
    };
    tmux.enable = true;
    vesktop.enable = true;
    waybar.enable = true;
    zoxide.enable = true;
  };

  services = {
    avizo.enable = true;
    clipse.enable = true;
    hypridle.enable = true;
    hyprpaper.enable = true;
    playerctld.enable = true;
    ssh-agent.enable = true;
    swaync.enable = true;
  };

  home = {
    darkMode.enable = true;

    presets = {
      dev.enable = true;
      screenCapture.enable = true;
      systemUtils.enable = true;
    };

    packages = with pkgs; [
      google-chrome
      brave
      obsidian
      slack
      spotify
      todoist-electron
    ];

    file."${config.home.homeDirectory}/Pictures/Wallpapers" = {
      source = ../../../resources/wallpapers;
      recursive = true;
    };

    pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      gtk.enable = true;
      hyprcursor.enable = true;
      size = 18;
    };

    sessionVariables = {
      XCURSOR_SIZE = "24";

      # Hardware acceleration
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
    };
  };
}
