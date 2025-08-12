{
  config,
  lib,
  pkgs,
  ...
}:

let
  gitIsEnabled = config.programs.git.enable;
in
{
  config.programs.git = lib.mkIf gitIsEnabled {
    # TODO Set these options elsewhere?
    package = pkgs.gitFull;
    userName = "Andreas Skønberg";
    userEmail = "andreas.skonberg@gmail.com";
    extraConfig = {
      credential.helper = "libsecret";
      init.defaultBranch = "main";
      push = {
        autoSetupRemote = true;
      };
    };
    delta.enable = true;
  };
}
