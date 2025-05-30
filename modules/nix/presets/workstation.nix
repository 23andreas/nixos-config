{ ... }:

{
  imports = [
    ../modules/1password.nix
    ../modules/hyprland.nix
    ../modules/pipewire.nix
    ../modules/polkit.nix
    # TODO move bluetooth out of this
    ../hardware/bluetooth.nix
    ../modules/gnome.nix
    ../modules/fonts.nix
  ];
}
