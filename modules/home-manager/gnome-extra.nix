{ pkgs, ... }:

{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          pkgs.gnomeExtensions.pano.extensionUuid
          pkgs.gnomeExtensions.caffeine.extensionUuid
          pkgs.gnomeExtensions.just-perfection.extensionUuid
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "kitty super";
        command = "kitty";
        binding = "<Super>Return";
      };

      "org/gnome.mutter" = {
        # overlay-key = "<Super>space";
        "edge-tiling" = false;
      };

    };
  };
}

#TODO
# Notifications hotkey?
# Clear notifiactions hotkey?
# Fix forge border
# Pano hotkey
# Chrome hotkey
# Files?
# screensharing
