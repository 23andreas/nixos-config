
{ config, lib, ... }:
let
  cfg = config.nixosConfig.app.wezterm;
in
{
  options.nixosConfig.app.wezterm = {
    enable = lib.mkEnableOption "Wezterm";
    isDefaultTerminal = lib.mkOption {
      default = true;
      description = "Set Wezterm as default terminal";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    # home.sessionVariables.TERMINAL = lib.mkIf cfg.isDefaultTerminal "wezterm";

    programs.wezterm = {
      enable = true;

      extraConfig = ''
        local config = wezterm.config_builder()

        config.color_scheme = 'AdventureTime'

        return config
      '';
    };
  };
}
