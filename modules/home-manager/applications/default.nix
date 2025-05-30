{ ... }:

{
  imports = [
    ./gui/rofi/rofi.nix
    # ./gui/dicord.nix
    # ./gui/google-chrome.nix
    # ./gui/mpv.nix
    # ./gui/obsidian.nix.nix
    # ./gui/slack.nix
    # ./gui/spotify.nix
    # ./gui/telegram.nix
    # ./gui/todoist.nix
    # ./gui/visual-studio-code.nix

    # ./services/playerctld.nix

    ./terminal/neovim
    ./terminal/tmux
    ./terminal/atuin.nix
    ./terminal/clipse.nix
    ./terminal/git.nix
    ./terminal/kitty.nix
    ./terminal/rbw.nix
    ./terminal/zoxide.nix
  ];
}
