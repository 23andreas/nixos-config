{ config, lib, ... }:

let
  xserverEnabled = config.services.xserver.enable;
in
{
  options = {
    input.swapCapsAndEscape = lib.mkEnableOption "swap caps and escape";
  };

  config = lib.mkIf (config.input.swapCapsAndEscape && xserverEnabled) {
    services.xserver.xkb.options = "caps:swapescape";
  };
}

