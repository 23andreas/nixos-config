{ config, lib, pkgs, ... }:

let
  cfg = config.nixosConfig.profiles.leisure;
in
{
  options.nixosConfig.profiles.leisure =
    {
      enable = lib.mkEnableOption "Enable leisure profile";
    };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      telegram-desktop
    ];

    nixosConfig.app = {
      discord.enable = true;
      discord.enableWaylandFix = true;
    };
  };
}
