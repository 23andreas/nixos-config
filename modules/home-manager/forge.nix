{ pkgs, ... }:

{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          pkgs.gnomeExtensions.forge.extensionUuid
        ];
      };

      "org/gnome/shell/keybindings" = {
        toggle-overview = [ "<Super>space" ];

        "switch-to-application-1" = [ ];
        "switch-to-application-2" = [ ];
        "switch-to-application-3" = [ ];
        "switch-to-application-4" = [ ];
        "switch-to-application-5" = [ ];
        "switch-to-application-6" = [ ];
        "switch-to-application-7" = [ ];
        "switch-to-application-8" = [ ];
        "switch-to-application-9" = [ ];
      };

      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>c" ];

        "switch-to-workspace-1" = [ "<Super>1" ];
        "switch-to-workspace-2" = [ "<Super>2" ];
        "switch-to-workspace-3" = [ "<Super>3" ];
        "switch-to-workspace-4" = [ "<Super>4" ];
        "switch-to-workspace-5" = [ "<Super>5" ];
        "switch-to-workspace-6" = [ "<Super>6" ];
        "switch-to-workspace-7" = [ "<Super>7" ];
        "switch-to-workspace-8" = [ "<Super>8" ];
        "switch-to-workspace-9" = [ "<Super>9" ];
      };

      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 10;
      };

      # "org/gnome/mutter" = {
      #   overlay-key = "<Super>space";
      # };

      "org/gnome/shell/exntensions/forge" = {
        window-gap-size = 2;
        window-gap-size-increment = 1;
        window-gap-hidden-on-single = true;
      };

      "org/gnome/shell/extensions/forge/keybindings" = {
        window-move-left = [ "<Alt><Super>h" ];
        window-move-down = [ "<Alt><Super>j" ];
        window-move-up = [ "<Alt><Super>k" ];
        window-move-right = [ "<Alt><Super>l" ];

        window-toggle-float = [ "<Super>v" ];
      };
    };
  };
}
