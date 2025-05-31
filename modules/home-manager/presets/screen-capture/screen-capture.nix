{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.home.presets.screenCapture;
  record = pkgs.writeScriptBin "record" (builtins.readFile ./record.sh);
in
{
  options.home.presets.screenCapture = {
    enable = lib.mkEnableOption "Enable screen capture preset";
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

      record
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
