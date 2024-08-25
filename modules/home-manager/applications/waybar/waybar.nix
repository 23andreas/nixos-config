{ lib, config, ... }:

let
  cfg = config.nixosConfig.app.waybar;
in
{
  options.nixosConfig.app.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
    };

    # programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    #   mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    # });
  };
}
