{ config, lib, ... }:
let
  cfg = config.nixosConfig.app.foot;
in
{
  options.nixosConfig.app.foot = {
    enable = lib.mkEnableOption "foot";
    isDefaultTerminal = lib.mkOption {
      default = false;
      description = "Set foot as default terminal";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.TERMINAL = lib.mkIf cfg.isDefaultTerminal "foot";

    programs.foot = {
      enable = true;
      server.enable = true;

      settings = {
        main = {
          font = "SFMono Nerd Font:size=11";
          # scrollback_lines = 10000;
          # clipboard = "primary";
          # detect_urls = true;
        };
      };
    };
  };
}
