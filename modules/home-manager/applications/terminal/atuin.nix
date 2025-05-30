{ config, lib, ... }:

let
  autinIsEnabled = config.programs.atuin.enable;
in
{
  programs.atuin = lib.mkIf autinIsEnabled {
    enableFishIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
  };
}
