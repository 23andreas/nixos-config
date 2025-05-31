{ ... }:

{
  imports = [
    ../modules/cachix.nix
    ../modules/sops.nix
    ../system/locale.nix
    ../system/network.nix
    ../system/nix-settings.nix
  ];
}
