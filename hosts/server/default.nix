{ config, ... }:
let
  hostname = "server";
in {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix

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

  # qbittorrent
  # https://github.com/NixOS/nixpkgs/pull/337109 - looks promising
  # https://github.com/NixOS/nixpkgs/pull/287923 :(

  # home assistant
  # zigbee2mqtt

  # authelia
  # traefik / nginx

  services = {
    plex = {
      enable = true;
      openFirewall = true;
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

