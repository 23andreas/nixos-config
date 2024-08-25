{ config, ... }:
let
  hostname = "server";
in {
  imports = [
    ../../modules/nix/core
    ./hardware-configuration.nix
  ];

  sops = {
    secrets = {
      "${hostname}/cachix-credentials-file" = { };
      "home-desktop/ssh-key/public" = { };
      # "work-laptop/ssh-key/public" = { };
    };
  };

  _23andreas = {
    hostname = hostname;
    users = {
      andreas = {
        groups = [ "networkmanager" "wheel" ];
        nixSettingsAllowed = true;
        sshAuthorizedKeyFiles = [
          config.sops.secrets."home-desktop/ssh-key/public".path
          # config.sops.secrets."work-laptop/ssh-key/public".path
        ];
      };
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

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

  system.stateVersion = "24.11";
}

