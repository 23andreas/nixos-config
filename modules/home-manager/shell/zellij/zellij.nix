{ config, lib, ... }:

let
  cfg = config.nixosConfig.shell.zellij;
in
{
  options.nixosConfig.shell.zellij = {
    enable = lib.mkEnableOption "Enable Zellij";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      # enableFishIntegration = true;
    };
    # xdg.configFile.zellj = {
    #   source = ./config.kdl;
    #   target = "zellij/config.kdl";
    # };
  };
}
