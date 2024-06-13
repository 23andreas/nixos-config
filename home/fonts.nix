{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "SourceCodePro"
        "IBMPlexMono"
      ];
    })
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Source Code Pro" "FiraCode Nerd Font" ];
      };
    };
  };
}
