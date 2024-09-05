{ config, lib, ... }:
let
  cfg = config.nixosConfig.app.wofi;
in
{
  options.nixosConfig.app.wofi = {
    enable = lib.mkEnableOption "wofi";
    isDefaultTerminal = lib.mkOption {
      default = true;
      description = "Set wofi as default terminal";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.TERMINAL = lib.mkIf cfg.isDefaultTerminal "wofi";

    programs.wofi = {
      enable = true;
    };
  };
}
