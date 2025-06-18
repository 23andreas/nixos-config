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
    ./logitech-receiver-wake-on-suspend-fix.nix

    ../../modules/nix/presets/core.nix
    ../../modules/nix/presets/workstation.nix

    ../../modules/nix/hardware/bluetooth.nix
    ../../modules/nix/hardware/nvidia.nix
    ../../modules/nix/hardware/ssd.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.andreas = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [
      "networkmanager"
      "docker"
      "wheel"
    ];
    group = "users";
    home = "/home/andreas";
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets."users/andreas/hashed-password".path;
  };

  environment.systemPackages = with pkgs; [
    os-prober
    veracrypt
  ];

  programs.shell.envVarFiles = {
    ANTHROPIC_API_KEY = config.sops.secrets."users/andreas/anthropic-api-key".path;
    OPENAI_API_KEY = config.sops.secrets."users/andreas/openai-api-key".path;
    GROQ_API_KEY = config.sops.secrets."users/andreas/groq-api-key".path;
    TAVILY_API_KEY = config.sops.secrets."users/andreas/tavily-api-key".path;
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
    "users/andreas/groq-api-key" = {
      owner = "andreas";
    };
    "users/andreas/tavily-api-key" = {
      owner = "andreas";
    };
    "${hostname}/github-access-token-file" = { };
    "${hostname}/cachix-credentials-file" = { };
    "${hostname}/ssh-key/public" = { };
  };

  nix = {
    settings.allowed-users = [ "andreas" ];
    extraOptions = ''
      !include ${config.sops.secrets."${hostname}/github-access-token-file".path}
    '';
  };

  networking.hostName = hostname;
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
