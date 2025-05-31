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

    ../../modules/nix/presets/core.nix
    ../../modules/nix/presets/server.nix

    ../../modules/nix/modules/home-assistant.nix
  ];

  users.users.andreas = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    group = "users";
    home = "/home/andreas";
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets."users/andreas/hashed-password".path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICOZWSjNZelhP3CAaIrmLiMMeaTP6EqPz+m6WDVh1meX"
    ];
  };

  # IDEAS
  # Monitoring
  # - Grafana
  # - fail2ban
  # - syslog
  # Firejail?
  # Backups/Documents

  security.pam = {
    sshAgentAuth.enable = true;
    services.sudo.sshAgentAuth = true;
  };

  # Move to sonarr?
  # nixpkgs.config.permittedInsecurePackages = [
  #   "dotnet-sdk-6.0.428"
  #   "aspnetcore-runtime-6.0.36"
  # ];

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

  networking.hostName = hostname;

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
