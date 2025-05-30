{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nixosConfig.app.discord;
in
{
  options.nixosConfig.app.discord = {
    enable = lib.mkEnableOption "Discord";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vesktop
      # discord
    ];
  };
}
