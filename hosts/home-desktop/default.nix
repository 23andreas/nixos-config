{ pkgs, config, ... }:

let
  hostname = "home-desktop";
in
{
  imports = [
    ../../modules/nix/core

    ./hardware-configuration.nix
    ./logitech-receiver-wake-on-suspend-fix.nix

    ../../modules/nix/presets/workstation.nix

    ../../modules/nix/hardware/nvidia.nix
    ../../modules/nix/hardware/intel.nix
    ../../modules/nix/hardware/ssd.nix
  ];

  sops.secrets = {
    "users/andreas/hashed-password".neededForUsers = true;
    "users/andreas/anthropic-api-key" = {
      owner = "andreas";
    };
    "${hostname}/github-access-token-file" = { };
    "${hostname}/cachix-credentials-file" = { };
    "${hostname}/ssh-key/public" = { };
  };

  _23andreas = {
    hostname = hostname;
    users = {
      andreas = {
        homeManagerFile = builtins.toPath ../../modules/home-manager/users/andreas.nix;
        hashedPasswordFile = config.sops.secrets."users/andreas/hashed-password".path;
        groups = [
          "networkmanager"
          "wheel"
        ];
        nixSettingsAllowed = true;
        envVarFiles = {
          ANTHROPIC_API_KEY = config.sops.secrets."users/andreas/anthropic-api-key".path;
        };
      };
    };
  };

  # Windows :(
  time.hardwareClockInLocalTime = true;

  environment.sessionVariables = {
    # NIXOS_OZONE_WL = "1";
  };

  nix.extraOptions = ''
    !include ${config.sops.secrets."${hostname}/github-access-token-file".path}
  '';

  environment.systemPackages = with pkgs; [
    os-prober
    recyclarr

    tdl
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
