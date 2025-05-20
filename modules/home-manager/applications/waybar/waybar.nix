{ lib, config, ... }:

let
  cfg = config.nixosConfig.app.waybar;
in
{
  options.nixosConfig.app.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf cfg.enable {
    # catppuccin.waybar.enable = false;

    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
