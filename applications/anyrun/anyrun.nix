{ inputs, pkgs, ... }:

{
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    gtk-layer-shell
    gtk3
    pango
    cairo
    # gdk-pixbuf2
    # glib2
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
}

