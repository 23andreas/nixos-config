{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "SourceCodePro"
      ];
    })

    # fira

    # source-sans
    # source-sans-pro
    # source-code-pro

    # roboto
    # roboto-mono

    # noto-fonts

    inputs.apple-fonts.packages.${pkg.system}.sf-pro-nerd
    inputs.apple-fonts.packages.${pkg.system}.sf-mono-nerd
    inputs.apple-fonts.packages.${pkg.system}.ny-nerd
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "SFProText Nerd Font" ];
        serif = [ "NewYork Nerd Font" ];
        monospace = [ "SFMono Nerd Font" "Source Code Pro" "FiraCode Nerd Font" ];
      };
    };
  };
}
