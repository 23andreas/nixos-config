{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.shell;

in
{
  options.programs.shell.envVarFiles = lib.mkOption {
    type = lib.types.attrsOf lib.types.path;
    default = { };
    description = ''
      A set of name→file‐path.  When Fish starts, it will do
      `set -x NAME (cat FILE)`.  In other words, this must be
      an attrset whose values are full paths (to secret files).
    '';
  };

  config = {
    environment.systemPackages = [
      pkgs.starship
    ];
    programs.starship.enable = true;

    programs.fish = {
      enable = true;
      shellInit = ''
        ${lib.concatStringsSep "\n" (
          lib.mapAttrsToList (name: path: ''
            set -x ${name} (cat ${path})
          '') cfg.envVarFiles
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
  };
}
