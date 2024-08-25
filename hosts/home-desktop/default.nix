{ pkgs, config, ... }:

{
  imports = [
    ../../modules/nix/core

    ./hardware-configuration.nix
    ./logitech-receiver-wake-on-suspend-fix.nix

    ../../modules/nix/presets/workstation.nix

    ../../modules/nix/hardware/nvidia.nix
    ../../modules/nix/hardware/intel.nix
    ../../modules/nix/hardware/ssd.nix
  ];

  sops.secrets = {
    "users/andreas/hashed_password".neededForUsers = true;
    "home-desktop/cachix-credentials-file" = { };
  };

  _23andreas = {
    hostname = "home-desktop";
    users = {
      andreas = {
        homeManagerFile = builtins.toPath ../../modules/home-manager/users/andreas.nix;
        hashedPasswordFile = config.sops.secrets."users/andreas/hashed_password".path;
        groups = [ "networkmanager" "wheel" ];
        nixSettingsAllowed = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    os-prober
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

  hardware.keyboard.zsa.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

