{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono

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
        monospace = [
          "SFMono Nerd Font"
          "Source Code Pro"
          "FiraCode Nerd Font"
        ];
      };
    };
  };
}
