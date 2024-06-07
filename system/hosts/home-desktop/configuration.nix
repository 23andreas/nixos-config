{ pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../../modules/nvidia.nix
      ../../modules/intel.nix
      ../../modules/ssd.nix

      ../../modules/system/locale.nix
      ../../modules/system/sound.nix
      ../../modules/system/gnome-polkit.nix

      ../../modules/suites/gnome.nix
    ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org"
      "https://23andreas.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "23andreas.cachix.org-1:P9ng+DdiASGCO+NbxXnfeWPh66pvkb62xsRAN30JyTc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  environment.systemPackages = with pkgs; [
    os-prober
    home-manager
  ];

  # Boot loader
  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };

  hardware.logitech.wireless.enable = true;
  hardware.keyboard.zsa.enable = true;

  # Netorking
  networking.hostName = "andreas-office-nixos";
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.xkb.layout = "us,no";

  # Enable gnome with PaperWM
  suites.gnome.enable = true;
  suites.gnome.enablePaperWM = true;

  programs.hyprland.enable = true;
  # xdg portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      # xdg-desktop-portal-gtk
    ];
  };

  # Packages
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "andreas" ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  users.users.andreas = {
    isNormalUser = true;
    description = "Andreas";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # home-manager.useGlobalPkgs = true;
  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   users = {
  #     "andreas" = import ../../../home/users/andreas.nix;
  #   };
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

