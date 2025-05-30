{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.home.presets.systemUtils;
in
{
  options.home.presets.systemUtils = {
    enable = lib.mkEnableOption "Enable system-utils preset";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # TODO move this
      sops

      # TODO Audio control, move to sound.nix?
      pwvucontrol

      wget
      curl
    ];

    programs.fastfetch.enable = true;
    programs.btop.enable = true;
    programs.htop.enable = true;

    programs.bat = {
      enable = true;
    };

    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      keymap = {
        manager.prepend_keymap = [
          {
            run = [
              ''shell 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list' ''
              "yank"
            ];
            on = "y";
          }
        ];
      };
    };
  };
}
