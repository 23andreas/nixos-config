{ config, lib, ... }:

{
  # Workaround for
  # https://github.com/catppuccin/nix/issues/552

  catppuccin.mako.enable = lib.mkIf config.catppuccin.enable false;
}
