{ config, pkgs, ... }:

let
  hostname = "work-laptop";
in {
  imports = [
    ../../modules/nix/core

    ./hardware-configuration.nix
    # ../../disk-config.nix
    ./disk-config.nix

    ../../modules/nix/presets/workstation.nix
  ];

  _23andreas = {
    hostname = hostname;
    users = {
      andreas = {
        homeManagerFile = builtins.toPath ../../modules/home-manager/users/andreas.nix;
        hashedPasswordFile = config.sops.secrets."users/andreas/hashed_password".path;
        groups = [ "networkmanager" "wheel" ];
        nixSettingsAllowed = true;
      };
    };
  };

  sops = {
    secrets = {
      "users/andreas/hashed_password".neededForUsers = true;
      "${hostname}/cachix-credentials-file" = { };
      "${hostname}/github-access-token-file" = { };
      "${hostname}/ssh-key/public" = { };
    };
  };

  services.thermald.enable = true;
  powerManagement.powertop.enable = true;
  environment.systemPackages = with pkgs; [
    power-profiles-daemon
  ];


  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Github rate limits Cognite office IP without this
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

