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

        #Lsp
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
        nvim-treesitter-textobjects
        nvim-notify

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
