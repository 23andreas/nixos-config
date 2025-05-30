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
    ../../modules/nix/core

    ./hardware-configuration.nix
    # ./logitech-receiver-wake-on-suspend-fix.nix

    ../../modules/nix/presets/workstation.nix

    ../../modules/nix/hardware/nvidia.nix
    ../../modules/nix/hardware/intel.nix
    ../../modules/nix/hardware/ssd.nix

    inputs.home-manager.nixosModules.home-manager
  ];

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
      envVarFiles = {
        ANTHROPIC_API_KEY = config.sops.secrets."users/andreas/anthropic-api-key".path;
        OPENAI_API_KEY = config.sops.secrets."users/andreas/openai-api-key".path;
        GROQ_API_KEY = config.sops.secrets."users/andreas/groq-api-key".path;
        TAVILY_API_KEY = config.sops.secrets."users/andreas/tavily-api-key".path;
      };
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nix.settings.allowed-users = [
    "andreas"
  ];

  networking.hostName = hostname;

  # _23andreas = {
  #   hostname = hostname;
  #   users = {
  #     andreas = {
  #       # homeManagerFile = builtins.toPath ../../modules/home-manager/users/andreas.nix;
  #       hashedPasswordFile = config.sops.secrets."users/andreas/hashed-password".path;
  #       groups = [
  #         "networkmanager"
  #         "docker"
  #         "wheel"
  #       ];
  #       nixSettingsAllowed = true;
  #       envVarFiles = {
  #         ANTHROPIC_API_KEY = config.sops.secrets."users/andreas/anthropic-api-key".path;
  #         OPENAI_API_KEY = config.sops.secrets."users/andreas/openai-api-key".path;
  #         GROQ_API_KEY = config.sops.secrets."users/andreas/groq-api-key".path;
  #         TAVILY_API_KEY = config.sops.secrets."users/andreas/tavily-api-key".path;
  #       };
  #     };
  #   };
  # };

  virtualisation.docker.enable = true;

  # Windows :(
  time.hardwareClockInLocalTime = true;

  environment.sessionVariables = {
    # NIXOS_OZONE_WL = "1";
  };

  nix.extraOptions = ''
    !include ${config.sops.secrets."${hostname}/github-access-token-file".path}
  '';

  # TODO move this?
  environment.systemPackages = with pkgs; [
    os-prober
    # recyclarr
    # tdl
    veracrypt
  ];

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

  hardware.keyboard.zsa.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
