{
  inputs,
  pkgs,
  ...
}:
let
  currentActivityIconWidget = pkgs.stdenv.mkDerivation {
    name = "plasma-current-activity-icon";
    version = "5.1";
    src = ./plasmoids/org.kde.currentactivityicon;

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/plasma/plasmoids/org.kde.currentactivityicon
      cp -r $src/* $out/share/plasma/plasmoids/org.kde.currentactivityicon/
    '';
  };
in
{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  home.packages = with pkgs; [
    kdePackages.krohnkite
    # currentActivityIconWidget
  ];

  programs.plasma = {
    enable = true;

    window-rules = [
      {
        apply = {
          noborder = {
            value = true;
            apply = "initially";
          };
        };
        description = "Hide titlebar by default";
        match = {
          window-class = {
            value = ".*";
            type = "regex";
          };
        };
      }
      {
        description = "Brave work to work activity";
        match = {
          window-class = {
            value = "brave-work";
            type = "exact";
            match-whole = false;
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = {
            value = "Desktop_2";
            apply = "initially";
          };
          activity = {
            value = "d3ec6d8f-3e27-451c-ac9a-f0370ee90c00";
            apply = "initially";
          };
        };
      }
      {
        description = "Brave personal to personal activity";
        match = {
          window-class = {
            value = "brave-personal";
            type = "exact";
            match-whole = false;
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = {
            value = "Desktop_2";
            apply = "initially";
          };
          activity = {
            value = "95d614da-6314-4bcd-9032-b5ea30c864cd";
            apply = "initially";
          };
        };
      }
      {
        description = "Slack desktop 1";
        match = {
          window-class = {
            value = "Slack";
            type = "exact";
            match-whole = false;
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = {
            value = "Desktop_1";
            apply = "initially";
          };
          activity = {
            value = "d3ec6d8f-3e27-451c-ac9a-f0370ee90c00";
            apply = "initially";
          };
        };
      }
      {
        description = "Spotify desktop 5";
        match = {
          window-class = {
            value = "Spotify";
            type = "exact";
            match-whole = false;
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = {
            value = "Desktop_5";
            apply = "initially";
          };
        };
      }
      {
        description = "Vesktop";
        match = {
          window-class = {
            value = "vesktop";
            type = "exact";
            match-whole = false;
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = {
            value = "Desktop_1";
            apply = "initially";
          };
          activity = {
            value = "95d614da-6314-4bcd-9032-b5ea30c864cd";
            apply = "initially";
          };
        };
      }
      {
        description = "Fusion";
        match = {
          window-class = {
            value = "kitty-fusion";
            type = "exact";
            match-whole = false;
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = {
            value = "Desktop_2";
            apply = "initially";
          };
          activity = {
            value = "d3ec6d8f-3e27-451c-ac9a-f0370ee90c00";
            apply = "initially";
          };
        };
      }
      {
        description = "Nixos config";
        match = {
          window-class = {
            value = "kitty-nixos-config";
            type = "exact";
            match-whole = false;
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = {
            value = "Desktop_4";
            apply = "initially";
          };
          activity = {
            value = "95d614da-6314-4bcd-9032-b5ea30c864cd";
            apply = "initially";
          };
        };
      }
    ];
    kwin = {
      effects = {
        cube.enable = false;
        desktopSwitching.animation = "slide";
        fallApart.enable = false;
        minimization.animation = "off";
        shakeCursor.enable = false;
        translucency.enable = false;
        windowOpenClose.animation = "off";
        wobblyWindows.enable = false;
      };

      nightLight = {
        enable = true;
        location.latitude = "52.23";
        location.longitude = "21.01";
        mode = "location";
        temperature.night = 4000;
      };

      virtualDesktops = {
        number = 5;
        names = [
          "Desktop 1"
          "Desktop 2"
          "Desktop 3"
          "Desktop 4"
          "Desktop 5"
        ];
      };
    };

    panels = [
      {
        alignment = "center";
        height = 25;
        lengthMode = "fill";
        location = "top";
        opacity = "translucent";
        widgets = [
          # {
          #   name = "org.kde.currentactivityicon";
          # }
          {
            name = "org.kde.plasma.pager";
            config = {
              showWindowOutlines = true;
              showApplicationIconsOnWindowOutlines = true;
            };
          }
          {
            name = "org.kde.plasma.panelspacer";
          }
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                autoFontAndSize = false;
                boldText = true;
                dateDisplayFormat = "BesideTime";
                dateFormat = "longDate";
                fontFamily = "SFProDisplay Nerd Font SemiBold";
                fontStyleName = "Regular";
                fontSize = 10;
                fontWeight = 600;
                showWeekNumbers = true;
              };
            };
          }
          {
            name = "org.kde.plasma.panelspacer";
          }
          {
            systemTray = {
              icons.scaleToFit = false;
              items = {
                showAll = false;
                shown = [
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.keyboardlayout"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.bluetooth"
                ];
                hidden = [
                  "org.kde.plasma.battery"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.mediacontroller"
                  "plasmashell_microphone"
                  "xdg-desktop-portal-kde"
                  "zoom"
                  "1password"
                  "kde.merkuro.contact.applet"
                ];
                configs = {
                  "org.kde.plasma.notifications".config = {
                    Shortcuts = {
                      global = "Meta+N";
                    };
                  };
                };
              };
            };
          }
        ];
      }
    ];

    overrideConfig = true;

    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      gwenviewrc.ThumbnailView.AutoplayVideos = true;
      kcminputrc = {
        Keyboard.RepeatDelay = 400;
        # Mouse.cursorTheme = "phinger-cursors-light";
      };
      krunnerrc.General.FreeFloating = true;

      plasmanotifyrc.Notifications = {
        PopupPosition = "TopRight";
        PopupTimeout = 3000;
      };

      kactivitymanagerdrc = {
        activities = {
          "95d614da-6314-4bcd-9032-b5ea30c864cd" = "Personal";
          "d3ec6d8f-3e27-451c-ac9a-f0370ee90c00" = "Work";
        };
        activities-icons = {
          "95d614da-6314-4bcd-9032-b5ea30c864cd" = "bomber";
          "d3ec6d8f-3e27-451c-ac9a-f0370ee90c00" = "utilities-terminal";
        };
      };

      kdeglobals = {
        General = {
          BrowserApplication = "brave-browser.desktop";

          font = "SFProText Nerd Font,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
          menuFont = "SFProText Nerd Font,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
          smallestReadableFont = "SFProText Nerd Font,8,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
          toolBarFont = "SFProDisplay Nerd Font,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
          XftAntialias = true;
          XftHintStyle = "hintslight";
          XftSubPixel = "none";
        };
        KDE = {
          AnimationDurationFactor = 1;
        };
      };

      klaunchrc.FeedbackStyle.BusyCursor = false;
      klipperrc.General.MaxClipItems = 100;

      kwinrc = {
        Desktops.Rows = 1;
        Plugins = {
          krohnkiteEnabled = true;
          diminactiveEnabled = true;
          # screenedgeEnabled = false;
        };
        "Script-krohnkite" = {
          floatingClass = "brave-nngceckbapebfimnlniiiahkandclblb-Default,org.kde.kcalc,systemsettings";
          screenGapBetween = 3;
          screenGapBottom = 5;
          screenGapLeft = 5;
          screenGapRight = 5;
          screenGapTop = 5;

          columnsLayoutOrder = 1;
          binaryTreeLayoutOrder = 2;
          monocleLayoutOrder = 3;
          spreadLayoutOrder = 4;

          tileLayoutOrder = 0;
          threeColumnLayoutOrder = 0;
          cascadeLayoutOrder = 0;
          floatingLayoutOrder = 0;
          quarterLayoutOrder = 0;
          spiralLayoutOrder = 0;
          stackedLayoutOrder = 0;
          stairLayoutOrder = 0;
        };
        "Effect-diminactive" = {
          strength = 20;
        };
        Windows = {
          DelayFocusInterval = 0;
          FocusPolicy = "FocusFollowsMouse";
          NextFocusPrefersMouse = true;
        };
      };
      spectaclerc = {
        Annotations.annotationToolType = 8;
        General = {
          #   launchAction = "DoNotTakeScreenshot";
          #   showCaptureInstructions = false;
          useReleaseToCapture = true;
        };
        ImageSave.imageCompressionQuality = 100;
      };
    };

    hotkeys.commands = {
      # Terminal
      launch-kitty = {
        name = "Launch Kitty";
        key = "Meta+Return";
        command = "kitty";
      };

      launch-vicinae = {
        name = "Launch Vicinae";
        key = "Meta+Space";
        command = "vicinae toggle";
      };

      # launch-tms = {
      #   name = "Launch TMS Project Selector";
      #   key = "Meta+T";
      #   command = "tms-launcher";
      # };

      # Application launcher
      # rofi-drun = {
      #   name = "Rofi Application Launcher";
      #   key = "Meta+Space";
      #   command = "rofi -show drun -show-icons";
      # };

      # rofi-ssh = {
      #   name = "Rofi SSH Launcher";
      #   key = "Meta+Alt+Space";
      #   command = "rofi -show ssh -theme ssh.rasi";
      # };

      # Clipboard manager
      # clipse = {
      #   name = "Clipboard Manager";
      #   key = "Meta+\\";
      #   command = "kitty --class clipse -e clipse";
      # };

      # Password manager
      # rofi-rbw = {
      #   name = "Password Manager";
      #   key = "Meta+P";
      #   command = "rofi-rbw --selector-args=\"-theme rbw.rasi\"";
      # };

      # Emoji picker
      # rofimoji = {
      #   name = "Emoji Picker";
      #   key = "Meta+E";
      #   command = "rofimoji";
      # };

      # Calculator
      # rofi-calc = {
      #   name = "Calculator";
      #   key = "Meta+W";
      #   command = "rofi -show calc -modi calc -no-show-match -no-sort";
      # };

      # Browser - Default profile
      brave-default = {
        name = "Brave Browser (Default)";
        key = "Meta+Alt+;";
        command = "brave --class=brave-work --profile-directory=Default";
      };

      # Browser - Profile 1
      brave-profile1 = {
        name = "Brave Browser (Profile 1)";
        key = "Meta+;";
        command = "brave --class=brave-personal --profile-directory=\"Profile 1\"";
      };

      # Power menu
      # powermenu = {
      #   name = "Power Menu";
      #   key = "Meta+Q";
      #   command = "~/.local/bin/powermenu.sh | rofi -dmenu -i -theme powermenu.rasi | ~/.local/bin/powermenu.sh";
      # };

      # Screenshots
      # screenshot-fullscreen = {
      #   name = "Screenshot Fullscreen";
      #   key = "Print";
      #   command = "grimblast --freeze save output - | satty --filename - --output-filename ~/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png";
      # };
      #
      # screenshot-area = {
      #   name = "Screenshot Area";
      #   key = "Shift+Print";
      #   command = "grimblast --freeze save area - | satty --filename - --output-filename ~/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png";
      # };
      #
      # # Screen recording
      # recordmenu = {
      #   name = "Record Menu";
      #   key = "Meta+Print";
      #   command = "~/.local/share/recordmenu.sh | rofi -dmenu -i -theme recordmenu.rasi | ~/.local/share/recordmenu.sh";
      # };

      # Media controls
      # playerctl-play-pause = {
      #   name = "Play/Pause Media";
      #   key = "XF86AudioPlay";
      #   command = "playerctl play-pause";
      # };
      #
      # spotify-play-pause = {
      #   name = "Spotify Play/Pause";
      #   key = "Meta+XF86AudioPlay";
      #   command = "playerctl --player=spotify play-pause";
      # };
      #
      # playerctl-previous = {
      #   name = "Previous Track";
      #   key = "XF86AudioPrev";
      #   command = "playerctl previous";
      # };
      #
      # playerctl-next = {
      #   name = "Next Track";
      #   key = "XF86AudioNext";
      #   command = "playerctl next";
      # };
      #
      # spotify-previous = {
      #   name = "Spotify Previous";
      #   key = "Meta+XF86AudioPrev";
      #   command = "playerctl --player=spotify previous";
      # };
      #
      # spotify-next = {
      #   name = "Spotify Next";
      #   key = "Meta+XF86AudioNext";
      #   command = "playerctl --player=spotify next";
      # };
      #
      # # Volume controls
      # volume-up = {
      #   name = "Volume Up";
      #   key = "XF86AudioRaiseVolume";
      #   command = "volumectl -u up";
      # };
      #
      # volume-down = {
      #   name = "Volume Down";
      #   key = "XF86AudioLowerVolume";
      #   command = "volumectl -u down";
      # };
      #
      # volume-mute = {
      #   name = "Volume Mute";
      #   key = "XF86AudioMute";
      #   command = "volumectl toggle-mute";
      # };
      #
      # mic-mute = {
      #   name = "Microphone Mute";
      #   key = "XF86AudioMicMute";
      #   command = "volumectl -m toggle-mute";
      # };
      #
      # # Brightness controls
      # brightness-up = {
      #   name = "Brightness Up";
      #   key = "XF86MonBrightnessUp";
      #   command = "lightctl up";
      # };
      #
      # brightness-down = {
      #   name = "Brightness Down";
      #   key = "XF86MonBrightnessDown";
      #   command = "lightctl down";
      # };
    };

    shortcuts = {
      ksmserver = {
        "Lock Session" = [ ];
      };
      krunner = {
        "_launch" = [ ];
      };
      plasmashell = {
        "activate application launcher" = [ ];
        "activate task manager entry 1" = [ ];
        "activate task manager entry 2" = [ ];
        "activate task manager entry 3" = [ ];
        "activate task manager entry 4" = [ ];
        "activate task manager entry 5" = [ ];
        "activate task manager entry 6" = [ ];
        "activate task manager entry 7" = [ ];
        "activate task manager entry 8" = [ ];
        "activate task manager entry 9" = [ ];
        "activate task manager entry 10" = [ ];
      };
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Meta+Del";

      kwin = {

        "Window Close" = "Meta+C";
        "Window Fullscreen" = "Meta+F";
        "Show Desktop" = [ ];
        "Toggles Tiles Editor" = [ ];

        KrohnkiteFocusLeft = "Meta+H";
        KrohnkiteFocusDown = "Meta+J";
        KrohnkiteFocusUp = "Meta+K";
        KrohnkiteFocusRight = "Meta+L";

        KrohnkiteShiftLeft = "Meta+Alt+H";
        KrohnkiteShiftDown = "Meta+Alt+J";
        KrohnkiteShiftUp = "Meta+Alt+K";
        KrohnkiteShiftRight = "Meta+Alt+L";
        KrohnkiteIncreaseRatio = "Meta+Equal";
        KrohnkiteDecreaseRatio = "Meta+Minus";
        KrohnkiteIncrease = "Meta+I";
        KrohnkiteDecrease = "Meta+D";
        KrohnkitetoggleDock = "Meta+Z";
        KrohnkiteToggleFloat = "Meta+Y";

        "Switch to Desktop 1" = [
          "Meta+1"
          "Meta+6"
        ];
        "Switch to Desktop 2" = [
          "Meta+2"
          "Meta+7"
        ];
        "Switch to Desktop 3" = [
          "Meta+3"
          "Meta+8"
        ];
        "Switch to Desktop 4" = [
          "Meta+4"
          "Meta+9"
        ];
        "Switch to Desktop 5" = [
          "Meta+5"
          "Meta+0"
        ];

        # Move window to desktop shortcuts
        "Window to Desktop 1" = [
          "Meta+Alt+1"
          "Meta+Alt+6"
        ];
        "Window to Desktop 2" = [
          "Meta+Alt+2"
          "Meta+Alt+7"
        ];
        "Window to Desktop 3" = [
          "Meta+Alt+3"
          "Meta+Alt+8"
        ];
        "Window to Desktop 4" = [
          "Meta+Alt+4"
          "Meta+Alt+9"
        ];
        "Window to Desktop 5" = [
          "Meta+Alt+5"
          "Meta+Alt+0"
        ];

        # Disable default zoom shortcuts to avoid conflicts
        "Zoom In" = "Meta+Ctrl+=";
        "Zoom Out" = "Meta+Ctrl+-";
      };
    };

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";
      iconTheme = "breeze-dark";
      # cursor.theme = "breeze_cursors";
      wallpaper = "/home/andreas/Pictures/Wallpapers/alps.jpg";

      enableMiddleClickPaste = false;
    };

    kscreenlocker = {
      appearance.wallpaper = "/home/andreas/Pictures/Wallpapers/aishot-1773.jpg";
    };
  };
}
