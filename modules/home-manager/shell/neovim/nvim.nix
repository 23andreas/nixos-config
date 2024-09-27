{ config, lib, pkgs, ... }:

let
  cfg = config.nixosConfig.shell.nvim;
  renderMarkdownPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "render-markdown-nvim";
    version = "7.2.0"; # Adjust to the correct version
    src = pkgs.fetchFromGitHub {
      owner = "MeanderingProgrammer"; # Adjust to the correct author
      repo = "render-markdown.nvim"; # Adjust to the correct repository
      rev = "ffbe9f2395eacdce8a9fa967ac0fae75a6204f09"; # Replace with the correct commit hash
      sha256 = "sha256-AGQV6X5TgpeyeAiYw6ybrdoGiIiNrGN+DbU0NttGi6w="; # Replace with the correct sha256 hash
    };
  };
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
        # palenightfall-nvim
        # palenight-vim
        # cyberdream-nvim
        # kanagawa-nvim
        # tokyonight-nvim
        # onedark-nvim
        # onedarkpro-nvim
        # sonokai
        # nordic-nvim
        # everforest
        # bamboo-nvim
        # dracula-nvim
        # nightly-nvim
        # vscode-nvim

        plenary-nvim

        vim-tmux-navigator

        #Lsp
        lazy-lsp-nvim
        lsp-zero-nvim
        lsp_signature-nvim
        lspkind-nvim
        lspsaga-nvim

        nvim-autopairs

        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects

        indent-blankline-nvim
        nvim-treesitter-context
        nvim-treesitter-textobjects
        ssr-nvim
        treesj
        nvim-surround

        nvim-cmp
        cmp-nvim-lsp
        cmp-path
        cmp-buffer
        cmp_luasnip
        luasnip

        guard-nvim

        # hardtime-nvim
        # precognition-nvim

        trouble-nvim

        gitsigns-nvim
        vim-fugitive
        vim-rhubarb
        diffview-nvim

        which-key-nvim
        lualine-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        smart-open-nvim

        nvim-notify

        # undotree
        vim-mundo
        aerial-nvim

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

        syntax-tree-surfer

        # Avante & avante dependencies
        avante-nvim
        # render-markdown-nvim
        renderMarkdownPlugin

        img-clip-nvim
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
