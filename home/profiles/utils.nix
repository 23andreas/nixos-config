{ config, lib, pkgs, ... }:

let
  cfg = config.nixosConfig.profiles.utils;
in
{
  options.nixosConfig.profiles.utils = {
    enable = lib.mkEnableOption "Enable utils profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fastfetch
      yazi
    ];

    nixosConfig = {
      shell = {
        zellij.enable = true;
      };
    };
  };
}