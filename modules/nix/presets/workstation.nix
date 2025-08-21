{ ... }:

{
  imports = [
    ../modules/1password.nix
    # ../modules/gnome.nix
    ../modules/kde.nix
    ../modules/hyprland.nix

    ../system/audio.nix
    ../system/fonts.nix
    ../system/polkit.nix
    ../system/shell.nix
  ];
}
