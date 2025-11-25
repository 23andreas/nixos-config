{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.home.presets.dev;

  nixosConfigLauncher = pkgs.writeShellScript "launch-nixos-config-tmux" ''
    #!/usr/bin/env bash
    set -e

    # Check if window with this class already exists
    if ${pkgs.xdotool}/bin/xdotool search --class kitty-nixos-config &>/dev/null; then
      # Window exists, activate it
      ${pkgs.xdotool}/bin/xdotool search --class kitty-nixos-config windowactivate
    else
      # Window doesn't exist, create it
      kitty --listen-on unix:/tmp/mykitty \
        --class kitty-nixos-config \
        --directory=/home/andreas/code/nixos-config \
        -e tmux new -A -s nixos-config
    fi
  '';

  fusionLauncher = pkgs.writeShellScript "launch-fusion-tmux" ''
    #!/usr/bin/env bash
    set -e

    # Check if window with this class already exists
    if ${pkgs.xdotool}/bin/xdotool search --class kitty-fusion &>/dev/null; then
      # Window exists, activate it
      ${pkgs.xdotool}/bin/xdotool search --class kitty-fusion windowactivate
    else
      # Window doesn't exist, create it
      kitty --listen-on unix:/tmp/mykitty \
        --class kitty-fusion \
        --directory=/home/andreas/code/work/fusion \
        -e tmux new -A -s fusion
    fi
  '';
in
{
  options.home.presets.dev = {
    enable = lib.mkEnableOption "Enable dev tools";

  };

  config = lib.mkIf cfg.enable {


    xdg.desktopEntries."nixos-config" = {
      name = "nixos-config TMUX";
      comment = "Open or reuse Kitty window with tmux in the nixos-config folder";
      exec = "${nixosConfigLauncher}";
      icon = "kitty";
      terminal = false;
      categories = [
        "Utility"
        "TerminalEmulator"
      ];
    };

    xdg.desktopEntries."fusion-tmux" = {
      name = "fusion TMUX";
      comment = "Open or reuse Kitty window with tmux in the fusion folder";
      exec = "${fusionLauncher}";
      icon = "kitty";
      terminal = false;
      categories = [
        "Utility"
        "TerminalEmulator"
      ];
    };

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

      wakatime-cli
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
