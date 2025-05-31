{
  config,
  lib,
  pkgs,
  ...
}:

{

  config = lib.mkIf config.gtk.enable {
    home.packages = [
      pkgs.gtk3
    ];
  };
}
