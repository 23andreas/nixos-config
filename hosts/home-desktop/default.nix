{
  pkgs,
  config,
  inputs,
  ...
}:

let
  hostname = "home-desktop";
in
{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    # ./wireguard.nix
    ./logitech-receiver-wake-on-suspend-fix.nix

    # TEMP: Wifi diconnecting fix
    # ./disable-wifi-powersave.nix

    ../../modules/nix/presets/core.nix
    ../../modules/nix/presets/workstation.nix

    ../../modules/nix/hardware/bluetooth.nix
    ../../modules/nix/hardware/nvidia.nix
    ../../modules/nix/hardware/ssd.nix

    ../../modules/nix/modules/tailscale.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.andreas = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [
      "networkmanager"
      "docker"
      "wheel"
      "audio"
      "rtkit"
      "dialout"
      "operator"
    ];
    group = "users";
    home = "/home/andreas";
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets."users/andreas/hashed-password".path;
  };

  hardware.logitech.wireless.enable = true;

  environment.systemPackages = with pkgs; [
    os-prober
    veracrypt
    #TODO Move this
    prusa-slicer
  ];

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/prusaslicer" = [ "prusaslicer-url.desktop" ];
    };
  };

  programs.steam = {
    enable = true;
  };

  programs.shell.envVarFiles = {
    ANTHROPIC_API_KEY = config.sops.secrets."users/andreas/anthropic-api-key".path;
    OPENAI_API_KEY = config.sops.secrets."users/andreas/openai-api-key".path;
  };

  home-manager = {
    users.andreas = {
      home = {
        username = "andreas";
        homeDirectory = "/home/andreas";
        stateVersion = "23.11";
      };
      imports = [
        ../../modules/home-manager/users/andreas.nix
        inputs.catppuccin.homeModules.catppuccin
      ];
    };
    extraSpecialArgs = {
      inputs = inputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  sops.secrets = {
    "users/andreas/hashed-password".neededForUsers = true;
    "users/andreas/anthropic-api-key" = {
      owner = "andreas";
    };
    "users/andreas/openai-api-key" = {
      owner = "andreas";
    };
    "${hostname}/github-access-token-file" = { };
    "${hostname}/cachix-credentials-file" = { };
    "${hostname}/ssh-key/public" = { };
    "${hostname}/wireguard-private-key" = {
      owner = "root";
      group = "root";
      mode = "0600";
      path = "/etc/NetworkManager/wireguard-keys/server-wg";
    };
  };

  services.openssh = {
    enable = true;
    authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1bMDwYyT2X3vVJDe/tyM0+t1Q6eiiPO8JwuXLW1YcG"
    ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitEmptyPasswords = false;
      X11Forwarding = false;
      LoginGraceTime = "10s";
    };
  };

  nix = {
    settings.allowed-users = [ "andreas" ];
    extraOptions = ''
      !include ${config.sops.secrets."${hostname}/github-access-token-file".path}
    '';
  };

  # services.tailscale-headscale.enable = true;
  networking.hostName = hostname;
  networking.interfaces.eno1.wakeOnLan.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", NAME=="enp4s0", RUN+="${pkgs.ethtool}/bin/ethtool -s $name wol g"
  '';

  virtualisation.docker.enable = true;
  time.hardwareClockInLocalTime = true; # Windows :(

  hardware.keyboard.zsa.enable = true;

  # Boot loader
  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
