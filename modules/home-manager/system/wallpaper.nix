{
  lib,
  config,
  ...
}:

let
  defaultPath = "${config.home.homeDirectory}/Pictures/Wallpapers/0040.jpg";
in
{
  options.wallpaper.path = lib.mkOption {
    type = lib.types.path;
    default = defaultPath;
    description = "Image used by hyprpaper and hyprlock.";
  };

  config = lib.mkMerge [
    (lib.mkIf config.services.hyprpaper.enable {
      services.hyprpaper.settings = {
        preload = [ config.wallpaper.path ];
        wallpaper = [ ",${config.wallpaper.path}" ];
      };
    })

    (lib.mkIf config.programs.hyprlock.enable {
      programs.hyprlock.settings.background.path = config.wallpaper.path;
    })
  ];
}
