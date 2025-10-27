{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.home.presets.dev;
in
{
  options.home.presets.dev = {
    enable = lib.mkEnableOption "Enable dev tools";

  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.permittedInsecurePackages = [
      "beekeeper-studio-5.2.12"
    ];

    home.packages = with pkgs; [
      vim

      code-cursor
      # TEMP disabled, build error
      # aider-chat

      direnv
      devenv
      nixpkgs-fmt

      postman
      # Using EOL electron
      beekeeper-studio

      redisinsight

      k9s
      kubectl
      kubeseal
      minikube

      # OpenAI
      # temp disabled, build bug
      # codex

      # Rust TODO move into a shell.nix
      cargo
      rustc
      clippy

      arduino-cli
      arduino-ide

      cargo-generate

      # CLI for AVR microcontrollers
      avrdude
      # flash onto AVR microcontrollers using avrdude
      ravedude

      openscad
      openscad-lsp
      freecad

      webkitgtk_6_0

      # Global Node.js for copilot and other tools
      nodejs_22
    ];

    programs.vscode.enable = true;

    programs.claude-code = {
      enable = true;
      mcpServers = {
        playwright = {
          type = "stdio";
          command = "npx";
          args = [
            "@playwright/mcp@latest"
          ];
          env = { };
        };
        taskmaster-ai = {
          type = "stdio";
          command = "npx";
          args = [
            "-y"
            "task-master-ai"
          ];
          "env" = { };
        };

      };
    };

    programs.opencode = {
      enable = true;
      commands = {
        create-prd = ./commands/create-prd.md;
        generate-tasks = ./commands/generate-tasks.md;
        process-tasks = ./commands/process-task-list.md;
      };
    };

    programs.git.enable = true;
    programs.neovim.enable = true;
  };

}
