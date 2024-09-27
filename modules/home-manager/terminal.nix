{ config, users, lib, ...}:

let
  username = config.home.username;
  envVarFiles = users.${username}.envVarFiles;
in {
  programs.fish = {
    enable = true;
    # shellInit = ''
    #   set -x ANTHROPIC_API_KEY (cat ${config.sops.secrets."${hostname}/anthropic_api_key".path})
    # '';
    shellInit = ''
      ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: path: ''
        set -x ${name} (cat ${path})
      '') envVarFiles)}
    '';
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.navi = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
}

