{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nixosConfig.profiles.development;
in
{
  options.nixosConfig.profiles.development = {
    enable = lib.mkEnableOption "Enable development profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vim
      lazygit
      aider-chat

      direnv
      devenv
      nixpkgs-fmt

      postman
      beekeeper-studio

      turso-cli

      kubectl
      kubeseal
    ];

    programs.bat = {
      enable = true;
    };

    nixosConfig = {
      app = {
        vscode = {
          enable = true;
          enableWaylandFix = true;
        };
      };
      shell = {
        git.enable = true;
        nvim.enable = true;
      };
    };
  };
}
