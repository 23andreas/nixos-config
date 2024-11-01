{ lib, config, inputs, ... }:

let
  cfg = config.nixosConfig.app.walker;
in
{
  options.nixosConfig.app.walker = {
    enable = lib.mkEnableOption "Walker";
  };

  imports = [
    inputs.walker.homeManagerModules.default
  ];

  config = lib.mkIf cfg.enable {
    programs.walker = {
      enable = true;
      runAsService = true;

      config = {
        disabled = [ "runner" ];
        ui.anchors = [];
        "ignore_mouse" = true;
      };
    };
  };
}
