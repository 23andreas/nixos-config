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

      nixpkgs-fmt
      direnv
      postman

      # awscli2
      # kubectl

      devenv
      beekeeper-studio

      turso-cli
      # atlas
      # mongodb-compass
      mermerd
      aider-chat
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
