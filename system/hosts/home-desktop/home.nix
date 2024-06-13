{ pkgs, ... }:
  home.staet

{

  home.username = "andreas";
  home.homeDirectory = "/home/andreas";
  home.stateVersion = "23.11";

  imports = [
    ../../applications/ags/ags.nix
    ../../applications/anyrun/anyrun.nix
    ../../applications/neovim/nvim.nix
    ../../applications/slack/slack.nix
    ../../applications/zellij/zellij.nix
    ../../applications/kitty/kitty.nix
    ../../applications/git/git.nix

    ../../modules/system/terminal.nix

    ../../modules/suites/hyprland/hyprland.nix
  ];

  home.staet
  home.packages = with pkgs; [
    gnome.dconf-editor

    # CLI
    vim
    bat
    fastfetch
    lazygit

    # Utils
    nixpkgs-fmt
    direnv
    wl-clipboard
    cliphist

    # screenshot
    grim
    slurp

    mission-center # Task Manager

    obs-studio
    mpv # Video player
    obsidian
    discord
    spotify
    telegram-desktop

    firefox
    google-chrome
    # (google-chrome.override {
    # commandLineArgs = [
    # "--enable-features=UseOzonePlatform"
    # "--ozone-platform=wayland"
    # "--gtk-version=4"
    # "--disable-gpu"
    # ];
    # })

    (vscode.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
        "--password-store=gnome-libsecret"
      ];
    })
  ];

  gtk = {
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';
  };

  services.playerctld.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

