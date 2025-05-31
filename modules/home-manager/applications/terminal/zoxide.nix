{ config, lib, ... }:

let
  zoxideIsEnabled = config.programs.zoxide.enable;
in
{
  programs.zoxide = lib.mkIf zoxideIsEnabled {
    enableFishIntegration = true;
  };
}
