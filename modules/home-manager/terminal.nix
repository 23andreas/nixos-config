{
  config,
  users,
  lib,
  ...
}:

let
  username = config.home.username;
  envVarFiles = users.${username}.envVarFiles;
in
{
  programs.fish = {
    enable = true;
    shellInit = ''
      ${lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: path: ''
          set -x ${name} (cat ${path})
        '') envVarFiles
      )}
    '';
  };

  programs.atuin = {
    enable = false;
    enableFishIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # programs.navi = {
  #   enable = true;
  #   enableFishIntegration = true;
  # };

  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
}
