{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nixosConfig.profiles.utils;
in
{
  options.nixosConfig.profiles.utils = {
    enable = lib.mkEnableOption "Enable utils profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      sops

      # Audio control, move to sound.nix?
      pwvucontrol

      # safeeyes

      wget
      curl
    ];

    programs.fastfetch.enable = true;
    programs.btop.enable = true;
    programs.htop.enable = true;

    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
    };

    nixosConfig = {
      shell = {
        tmux.enable = true;
        zellij.enable = false;
      };
    };
  };
}
