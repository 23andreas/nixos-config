{ config, ... }:
let
  hostname = "server";
in {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ./media-services.nix
    ./nginx.nix

    ../../modules/nix/core
    ../../modules/nix/presets/server.nix
    ../../modules/nix/modules/home-assistant.nix
    ../../modules/nix/modules/glances.nix
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

  # IDEAS
  # Monitoring
  # - Grafana
  # - fail2ban
  # - syslog
  # Firejail?
  # eBooks?
  # Backups/Documents

  security.pam = {
    sshAgentAuth.enable = true;
    services.sudo.sshAgentAuth = true;
  };

  services.netdata = {
    enable = true;
  };

  sops = {
    secrets = {
      "users/andreas/hashed_password".neededForUsers = true;
      "${hostname}/cachix-credentials-file" = { };
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

