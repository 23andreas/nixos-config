{ pkgs, ...}:

{

  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Inconsolata"
      ];
    })
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Inconsolata" "FiraCode" ];
      };
    };
  };

}

