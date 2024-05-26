{ pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../../modules/hardware/nvidia.nix
      ../../modules/hardware/intel.nix
      ../../modules/hardware/ssd.nix

      ../../modules/system/locale.nix
      ../../modules/system/sound.nix
      ../../modules/system/gnome-polkit.nix

      ../../modules/suites/gnome.nix
    ];

  nix.settings = {
    builders-use-substitutes = true;
    substituters = [
      "https://cache.nixos.org"
      "https://nixcache.reflex-frp.org"
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
    ];
    trusted-public-keys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  home-manager.useGlobalPkgs = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "andreas" = import ./home.nix;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

