{ config, pkgs, ... }:
let
  hostname = "server";
in {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ./nginx.nix

    ../../modules/nix/core
    ../../modules/nix/presets/server.nix
    ../../modules/nix/modules/home-assistant.nix
  ];

  _23andreas = {
    hostname = hostname;
    users = {
      andreas = {
        hashedPasswordFile = config.sops.secrets."users/andreas/hashed_password".path;
        groups = [ "networkmanager" "wheel" ];
        nixSettingsAllowed = true;
        # Can't get this to work with sops secrets..
        # https://discourse.nixos.org/t/can-how-do-you-manage-ssh-authorized-keys-with-sops-nix/46467
        # hardcoding pub keys for now
        sshAuthorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICOZWSjNZelhP3CAaIrmLiMMeaTP6EqPz+m6WDVh1meX"
        ];
      };
    };
  };

  security.pam = {
    sshAgentAuth.enable = true;
    services.sudo.sshAgentAuth = true;
  };

  # Ideas
  # Nginx blocks in monitoring
  # Create separate users for services
  # Firejail?
  # Logging/monitoring
  # Grafana
  # eBooks?
  # Backups/Documents

  # https://github.com/NixOS/nixpkgs/pull/287923 :(
  environment.systemPackages = [
    pkgs.qbittorrent-nox
  ];

  services = {
    plex = {
      enable = true;
      openFirewall = true;
      # TODO pass in cpu for hw
      # accelerationDevices = ["*"];
    };
    sonarr = {
      enable = true;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      openFirewall = true;
    };
    bazarr = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };

  sops = {
    secrets = {
      "users/andreas/hashed_password".neededForUsers = true;
      "${hostname}/cachix-credentials-file" = { };
      # "home-desktop/ssh-key/public".neededForUsers = true;
      # "work-laptop/ssh-key/public" = { };
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

