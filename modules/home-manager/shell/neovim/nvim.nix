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
        catppuccin-nvim

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
        cmp_luasnip
        luasnip

        guard-nvim

        hardtime-nvim
        precognition-nvim

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
        # typescript-tools-nvim

        # zen-mode-nvim
        # colorizer

        indent-blankline-nvim
        # nvim-treesitter-context
        nvim-treesitter-textobjects
        #ssr.nvim?
        treesj
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


      # :luafile ~/.config/nvim/init.lua
      # :luafile ~/nixos/home/shell/neovim/config/init.lua
      extraConfig = ''
        :luafile ~/.config/nvim/init.lua
      '';
    };

    home.packages = [
      pkgs.wl-clipboard
      pkgs.cliphist
    ];

    # home.file.".config/nvim/init.lua".source = "/home/andreas/nixos/home/shell/neovim/config/init.lua";
    # xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "/home/andreas/nixos/home/shell/neovim/config/init.lua";
    xdg.configFile.nvim = {
      source = ./config;
      recursive = true;
    };
  };
}
