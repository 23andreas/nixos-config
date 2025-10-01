{ config, pkgs, ... }:
let
  hostname = "server";
  # TODO move this
  home-desktop-wol = pkgs.writeShellScriptBin "home-desktop-wol" ''
    ${pkgs.wakeonlan}/bin/wakeonlan -i 192.168.1.7 a0:ad:9f:1e:52:a7
  '';
in
{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ./media-services.nix

    ./nginx.nix
    ./postgresql.nix
    ./n8n.nix
    ./wireguard.nix

    ../../modules/nix/presets/core.nix
    ../../modules/nix/presets/server.nix

    # ../../modules/nix/modules/home-assistant.nix
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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1bMDwYyT2X3vVJDe/tyM0+t1Q6eiiPO8JwuXLW1YcG"
    ];
  };

  environment.systemPackages = with pkgs; [
    wakeonlan
    home-desktop-wol
  ];

  # services.k3s = {
  #   enable = true;
  #   role = "server";
  #   token = "hello";
  #   clusterInit = true;
  #
  #   extraFlags = [
  #     "--write-kubeconfig-mode=644"
  #     "--tls-san"
  #     "192.168.1.6"
  #   ];
  # };
  #
  # containers.worker1 = {
  #   autoStart = true;
  #   config =
  #     { pkgs, config, ... }:
  #     {
  #       networking.hostName = "worker1";
  #       services.k3s = {
  #         enable = true;
  #         role = "agent";
  #         serverAddr = "https://192.168.1.6:6443";
  #         token = "hello";
  #       };
  #     };
  # };

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

  sops = {
    secrets = {
      "users/andreas/hashed-password".neededForUsers = true;
      "${hostname}/cachix-credentials-file" = { };
      "${hostname}/nginx-andreas-basic-auth-file" = {
        owner = "nginx";
      };
      "${hostname}/acme-cloudflare-environment-file" = { };
      "${hostname}/wireguard-private-key" = {
        owner = "root";
        group = "root";
        mode = "0600";
      };
      # "${hostname}/mqtt_secrets" = {
      #   owner = "zigbee2mqtt";
      # };
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
