{
  lib,
  config,
  ...
}:

{
  config.services.hyprpaper = lib.mkIf config.services.hyprpaper.enable {
    settings.ipc = "on";
  };
}
