{ ... }:

{
  imports = [
    ../modules/openssh.nix
    ../modules/glances.nix
    ../modules/syncthing.nix
    ../system/shell.nix
    ../system/locale.nix
    ../system/nix-settings.nix
  ];
}
