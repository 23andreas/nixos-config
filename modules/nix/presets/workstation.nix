{ ... }:

{
  imports = [
    ../modules/1password.nix
    ../modules/hyprland.nix
    ../modules/pipewire.nix
    ../modules/polkit.nix
    ../hardware/bluetooth.nix
    ../modules/gnome.nix
  ];
}
