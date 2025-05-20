{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nixosConfig.profiles.screen-capture;
in
{
  options.nixosConfig.profiles.screen-capture = {
    enable = lib.mkEnableOption "Enable screen capture profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obs-studio

      grim
      slurp

      satty

      grimblast
      wf-recorder

      # used by recorder to convert output
      ffmpeg
      gifsicle

      # used by some scripts for notify-send command
      libnotify
    ];

    xdg.configFile."satty" = {
      text = ''
        [general]
        output-filename = "~/Pictures/Screenshots/Y-m-d_H:M:S.png"
      '';
      target = "satty/config.toml";
    };
  };
}
