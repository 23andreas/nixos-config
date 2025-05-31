{ config, lib, ... }:

let
  gitIsEnabled = config.programs.git.enable;
in
{
  config.programs.git = lib.mkIf gitIsEnabled {
    # TODO Set these options elsewhere?
    userName = "Andreas Skønberg";
    userEmail = "andreas.skonberg@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
