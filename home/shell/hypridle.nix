{ lib, config, ... }:

let
  cfg = config.nixosConfig.shell.hypridle;
in
{
  options.nixosConfig.shell.hypridle = {
    enable = lib.mkEnableOption "hypridle";
  };

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
        };
        listener = [{
          timeout = 500;
          on-timeout = "loginctl lock-session";
        }];
      };
    };
  };
}
