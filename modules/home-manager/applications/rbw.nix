{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixosConfig.app.rbw;
in
{
  options.nixosConfig.app.rbw = {
    enable = lib.mkEnableOption "rbw";
  };

  config = lib.mkIf cfg.enable {
    programs.rbw = {
      enable = true;
      settings = {
        email = "andreas.skonberg@gmail.com";
        pinentry = pkgs.pinentry-gnome3;
      };
    };
  };
}
