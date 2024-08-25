{ config, ... }:
{
  imports = [
    ../../modules/nix/core

    ./hardware-configuration.nix
    ../../disk-config.nix

    ../../modules/nix/presets/workstation.nix
  ];

  _23andreas = {
    hostname = "work-laptop";
    users = {
      andreas = {
        groups = [ "networkmanager" "wheel" ];
        nixSettingsAllowed = true;
      };
    };
  };

  sops = {
    secrets = {
      "users/andreas/hashed_password".neededForUsers = true;
      "work-laptop/cachix-credentials-file" = { };
      "work-laptop/github-access-token-file" = { };
    };
  };

  nix.extraOptions = ''
    !include ${config.sops.secrets."work-laptop/github-access-token-file".path}
  '';

  # Boot loader
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
      };
    };
  };

  hardware.keyboard.zsa.enable = true;

  system.stateVersion = "24.11";
}

