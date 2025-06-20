{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.home.presets.dev;
in
{
  options.home.presets.dev = {
    enable = lib.mkEnableOption "Enable dev tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vim

      direnv
      devenv
      nixpkgs-fmt

      postman
      # Using EOL electron
      # beekeeper-studio

      k9s
      kubectl
      kubeseal
      minikube

      # OpenAI
      codex

      # Rust TODO move into a shell.nix
      cargo
      rustc
    ];

    programs.git.enable = true;
    programs.neovim.enable = true;
  };

}
