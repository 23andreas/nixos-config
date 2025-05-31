{ pkgs, inputs, ... }:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono

      inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
      inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd
      inputs.apple-fonts.packages.${pkgs.system}.ny-nerd
    ];
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
