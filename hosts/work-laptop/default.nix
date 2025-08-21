{
  pkgs,
  config,
  inputs,
  ...
}:

let
  hostname = "work-laptop";
in
{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix

    ../../modules/nix/presets/core.nix
    ../../modules/nix/presets/workstation.nix

    # 9530 is not added yet
    # nixos-hardware.nixosModules.dell-xps-15-9520
    ./hardware-copy.nix
    ../../modules/nix/hardware/bluetooth.nix

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

  # TODO Move these?
  services.hardware.bolt.enable = true;
  services.thermald.enable = true;
  services.displayManager.sddm.enableHidpi = true;
  powerManagement.powertop.enable = true;
  environment.systemPackages = with pkgs; [
    power-profiles-daemon
  ];

  networking.hostName = hostname;
  virtualisation.docker.enable = true;

  hardware.keyboard.zsa.enable = true;

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
