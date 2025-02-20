{ config, pkgs, ... }:
let
  hostname = "server";
in
{
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
        hashedPasswordFile = config.sops.secrets."users/andreas/hashed-password".path;
        groups = [
          "networkmanager"
          "wheel"
          # "docker"
        ];
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

  # Move to sonarr?
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
    "aspnetcore-runtime-6.0.36"
  ];

  sops = {
    secrets = {
      "users/andreas/hashed-password".neededForUsers = true;
      "${hostname}/cachix-credentials-file" = { };
      "${hostname}/nginx-andreas-basic-auth-file" = {
        owner = "nginx";
      };
      "${hostname}/acme-cloudflare-environment-file" = { };
      "${hostname}/mqtt_secrets" = {
        owner = "zigbee2mqtt";
      };
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };

  fileSystems."/media" = {
    device = "media";
    fsType = "zfs";
  };
  services.zfs.autoScrub.enable = true;

  # Boot loader
  networking.hostId = "85d5eb1e";
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;

    loader = {
      timeout = 2;
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
