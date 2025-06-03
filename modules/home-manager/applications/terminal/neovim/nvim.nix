{
  config,
  pkgs,
  lib,
  ...
}:

let
  nvimIsEnabled = config.programs.neovim.enable;
in
{
  config = lib.mkIf nvimIsEnabled {

    home.packages = with pkgs; [
      ripgrep
      nodejs

      lua-language-server
      typescript-language-server
      typescript
      vscode-langservers-extracted
      nixd
      nixfmt-rfc-style

      # Rust
      rust-analyzer
      rustlings

      # telescope
      fzf
      fd

      # Octo.nvim
      gh

      gcc
      gnumake

      # for copilot chat
      lynx
      python313Packages.jedi-language-server

      # Copilot
      copilot-language-server
    ];

    programs.neovim = {
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;

      withNodeJs = true;

      # extraLuaPackages = ps: [ ps.magick ];
      # extraPackages = [ pkgs.imagemagick ];
    };

    home.file = {
      "./.config/nvim/" = {
        source = ./nvim;
        recursive = true;
      };
      "./.config/nvim/lua/config/init.lua".text = ''
        require("config.autocmds")
        require("config.keymap")
        require("config.open-in-gh")
        require("config.options")
      '';
    };
  };
}
