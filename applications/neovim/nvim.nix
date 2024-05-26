{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      vscode-nvim
      dracula-nvim

      lazy-lsp-nvim
      lsp-zero-nvim
      lsp_signature-nvim

      trouble-nvim

      oil-nvim
      nvim-web-devicons

      refactoring-nvim

      which-key-nvim
      lualine-nvim
      telescope-nvim
      nvim-treesitter.withAllGrammars
      nvim-notify

      rainbow-delimiters-nvim

      nvim-cmp
      cmp-nvim-lsp
      luasnip

      undotree
      vim-be-good
      zen-mode-nvim
    ];

    extraPackages = with pkgs; [
      tree-sitter

      # Lua
      lua-language-server

      # Nix
      nixpkgs-fmt
      statix

      # Telescope
      ripgrep
      fd
    ];

    extraConfig = ''
      :luafile ~/.config/nvim/init.lua
    '';
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}

