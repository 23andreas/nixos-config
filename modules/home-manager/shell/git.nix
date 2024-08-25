{ config, lib, ... }:

let
  cfg = config.nixosConfig.shell.git;
in
{
  options.nixosConfig.shell.git = {
    enable = lib.mkEnableOption "Git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = lib.mkIf cfg.enable {
      enable = true;
      userName = "Andreas Skønberg";
      userEmail = "andreas.skonberg@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        push = { autoSetupRemote = true; };
      };
    };
  };
}
