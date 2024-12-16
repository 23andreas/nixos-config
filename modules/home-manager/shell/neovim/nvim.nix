{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.nixosConfig.shell.nvim;

  treesitterWithGrammars = (
    pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
      p.bash
      p.comment
      p.css
      # p.csv
      p.dockerfile
      p.fish
      p.gitattributes
      p.gitignore
      p.go
      p.gomod
      p.gowork
      # p.graphql
      p.html
      # p.http
      p.javascript
      p.jq
      # p.jsdoc
      p.json
      p.json5
      # p.jsonc
      # p.kotlin
      p.lua
      p.make
      p.markdown
      p.markdown_inline
      p.nginx
      p.nix
      p.python
      # p.rust
      # p.scss
      # p.sql
      p.toml
      p.typescript
      p.yaml
    ])
  );

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };

in
{
  options.nixosConfig.shell.nvim = {
    enable = lib.mkEnableOption "Neovim";
    isDefaultEditor = lib.mkEnableOption "Sets EDITOR env variable to vim";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      nodejs
      wl-clipboard
      cliphist

      lua-language-server
      typescript-language-server
      typescript
      vscode-langservers-extracted
      nixd
      nixfmt-rfc-style

      # telescope
      fzf
      fd

      gcc
      gnumake

      # for copilot chat
      lynx

      # for diagram.nvim
      # mermaid-cli
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = cfg.isDefaultEditor;

      viAlias = true;
      vimAlias = true;

      withNodeJs = true;

      extraLuaPackages = ps: [ ps.magick ];
      extraPackages = [ pkgs.imagemagick ];

      # plugins = [
      #   treesitterWithGrammars
      # ];
    };

    home.file."./.config/nvim/" = {
      source = ./nvim;
      recursive = true;
    };

    home.file."./.config/nvim/lua/config/init.lua".text = ''
      require("config.autocmds")
      require("config.keymap")
      require("config.open-in-gh")
      require("config.options")
    '';

    # home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    #   recursive = true;
    #   source = treesitterWithGrammars;
    # };
  };
}
