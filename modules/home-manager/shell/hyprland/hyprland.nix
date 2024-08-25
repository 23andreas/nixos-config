{ config, lib, ... }:

let
  cfg = config.nixosConfig.shell.hyprland;
in
{
  options.nixosConfig.shell.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  imports = [
    ./settings.nix
    ./keybindings.nix
    ./monitors.nix
  ];

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.enable = true;
    # used for processing hyprctl json output in keybindings
    programs.jq.enable = true;
  };
}
