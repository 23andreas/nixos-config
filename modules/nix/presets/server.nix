{ ... }:

{
  imports = [
    ../modules/openssh.nix
    ../modules/glances.nix
    ../system/shell.nix
    ../system/locale.nix
    ../system/nix-settings.nix
  ];
}
