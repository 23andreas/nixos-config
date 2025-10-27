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
  programs.git = lib.mkIf gitIsEnabled {
    package = pkgs.gitFull;
    settings = {
      user = {
        email = "andreas.skonberg@gmail.com";
        name = "Andreas Skønberg";

      };
      credential.helper = "libsecret";
      init.defaultBranch = "main";
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.delta = lib.mkIf gitIsEnabled {
    enable = true;
    enableGitIntegration = true;
  };
}
