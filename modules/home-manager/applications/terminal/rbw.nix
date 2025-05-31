{
  config,
  lib,
  pkgs,
  ...
}:

let
  rbwIsEnabled = config.programs.rbw.enable;
in
{
  config.programs.rbw.settings = lib.mkIf rbwIsEnabled {
    email = "andreas.skonberg@gmail.com";
    pinentry = pkgs.pinentry-gnome3;
  };
}
