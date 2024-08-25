{ config, lib, pkgs, ... }:

let
  cfg = config.nixosConfig.profiles.screen-capture;
in
{
  options.nixosConfig.profiles.screen-capture =
    {
      enable = lib.mkEnableOption "Enable screen capture profile";
    };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      grim
      slurp
      obs-studio
    ];
  };
}
