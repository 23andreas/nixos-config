{ config, lib, ... }:

let
  clipseIsEnabled = config.services.clipse.enable;
in
{
  services.clipse = lib.mkIf clipseIsEnabled {
    imageDisplay = {
      type = "sixel";
    };
  };
}
