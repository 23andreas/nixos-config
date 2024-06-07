{ lib, config, inputs, pkgs, ... }:

let
  cfg = config.nixosConfig.app.anyrun;
in
{
  options.nixosConfig.app.anyrun = {
    enable = lib.mkEnableOption "Anyrun";
  };

  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      gtk-layer-shell
      gtk3
      pango
      cairo
    ];

    programs.anyrun = {
      enable = true;
      config = {
        layer = "top";
        x = { fraction = 0.5; };
        y = { fraction = 0.25; };
        width = { absolute = 800; };
        height = { absolute = 0; };
        plugins = [
          inputs.anyrun.packages.${pkgs.system}.applications
          inputs.anyrun.packages.${pkgs.system}.rink
          inputs.anyrun.packages.${pkgs.system}.websearch
        ];
        ignoreExclusiveZones = true;
        closeOnClick = true;
      };

      extraCss = ''
        #entry, #entry:focus, #entry:active {
          border: 0;
          border-radius: 0;
          outline: none;
        }

        #window {
          background-color: rgba(0, 0, 0, 0.7);
        }
      '';
    };
  };
}
