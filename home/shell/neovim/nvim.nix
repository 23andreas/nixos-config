{ config, lib, pkgs, ... }:

let
  cfg = config.nixosConfig.shell.nvim;
in
{
  options.nixosConfig.shell.nvim = {
    enable = lib.mkEnableOption "Neovim";
    isDefaultEditor = lib.mkEnableOption "Sets EDITOR env variable to vim";
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = lib.mkIf cfg.isDefaultEditor {
      EDITOR = "vim";
    };

    programs.neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        # Themes
        tokyonight-nvim
        vscode-nvim
        dracula-nvim
        rose-pine
        catppuccin-nvim
        cyberdream-nvim

        #Lsp
        lazy-lsp-nvim
        lsp-zero-nvim
        lsp_signature-nvim
        lspsaga-nvim

        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects

        nvim-cmp
        cmp-nvim-lsp
        cmp-path
        cmp-buffer
        luasnip

        trouble-nvim

        gitsigns-nvim
        vim-fugitive
        vim-rhubarb

        which-key-nvim
        lualine-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        nvim-notify

        undotree

        oil-nvim
        nvim-web-devicons

        # refactoring-nvim
        vim-be-good

        vim-illuminate
        # nvim-autopairs

        # auto-session
        # persistence-nvim
        vim-obsession

        # zen-mode-nvim
        # colorizer
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

    home.packages = [
      pkgs.wl-clipboard
      pkgs.cliphist
    ];

    xdg.configFile.nvim = {
      source = ./config;
      recursive = true;
    };
  };
}
