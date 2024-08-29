{ config, ... }:
let
  hostname = "server";
in {
  imports = [
    ../../modules/nix/core

    ./hardware-configuration.nix
    ./disk-config.nix

    ../../modules/nix/presets/server.nix
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

   # plex

   # sonarr
   # radarr
   # bazarr
   # prowlarr

   # qbittorrent
   # https://github.com/NixOS/nixpkgs/pull/287923 :(

   # home assistant
   # zigbee2mqtt

   # stash
   # authelia
   # traefik / nginx
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

