{
  config,
  lib,
  pkgs,
  ...
}:

let
  envVarFiles = config.specialArgs.envVarFiles or { };
in
{
  programs.fish = {
    enable = true;
    shellInit = ''
      ${lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: path: ''
          set -x ${name} (cat ${path})
        '') envVarFiles
      )}

      # TODO REMOVE THIS
      # hyprp: preload and set a wallpaper from ~/Pictures/Wallpapers
      function hyprp
        if test (count $argv) -eq 0
          echo "Usage: hyprp <filename>"
          return 1
        end
        set -l f "$HOME/Pictures/Wallpapers/$argv[1]"
        if not test -f $f
          echo "File not found: $f"
          return 2
        end
        hyprctl hyprpaper preload $f; and hyprctl hyprpaper wallpaper ",$f"
      end
    '';
  };

  environment.systemPackages = [
    pkgs.starship
  ];

  programs.starship.enable = true;
  # programs.starship.enableFishIntegration = true;
}
