{ lib, config, ... }:

{

  config = lib.mkIf config.programs.waybar.enable {
    # catppuccin.waybar.enable = false;

    programs.waybar = {
      # enable = true;
      systemd.enable = true;
    };
  };
}
