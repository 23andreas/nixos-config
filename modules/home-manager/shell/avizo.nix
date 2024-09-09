
{ config, lib, ... }:

let
  cfg = config.nixosConfig.shell.avizo;
in
{
  options.nixosConfig.shell.avizo = {
    enable = lib.mkEnableOption "Avizo";
  };

  config = lib.mkIf cfg.enable {
    services.avizo = lib.mkIf cfg.enable {
      enable = true;
      settings = {
        default = {
          time = 0.5;
        };
      };
    };
  };
}
