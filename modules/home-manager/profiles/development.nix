{
  config,
  lib,
  pkgs,
  inputs,
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

      direnv
      devenv
      nixpkgs-fmt

      postman
      # Using EOL electron
      # beekeeper-studio

      kubectl
      kubeseal

      goose-cli
      aider-chat
      codex
      inputs.mcp-hub.packages."${system}".default
    ];

    xdg.configFile."mcp-hub" = {
      source = ./servers.json;
      target = "mcp-hub/servers.json";
    };

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
