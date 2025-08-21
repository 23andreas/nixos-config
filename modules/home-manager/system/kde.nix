{
  inputs,
  pkgs,
  ...
}:
{

  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  home.packages = with pkgs; [
    kdePackages.krohnkite
  ];

  programs.plasma = {
    enable = true;

    spectacle = {
      shortcuts = {
        # captureEntireDesktop = "";
        # captureRectangularRegion = "";
        # launch = "";
        # recordRegion = "Meta+Shift+R";
        # recordScreen = "Meta+Ctrl+R";
        # recordWindow = "";
      };
    };

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
        apply = {
          desktops = "Desktop_1";
          desktopsrule = "3";
        };
        description = "Assign Slack to Desktop 1";
        match = {
          window-class = {
            value = "Slack";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
      }
      {
        apply = {
          desktops = "Desktop_10";
          desktopsrule = "3";
        };
        description = "Assign Spotify to Desktop 10";
        match = {
          window-class = {
            value = "Spoitfy";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
      }
    ];

    kwin = {
      effects = {
        cube.enable = false;
        desktopSwitching.animation = "slide";
        # dimAdminMode.enable = false;

        fallApart.enable = false;
        # fps.enable = false;
        minimization.animation = "off";
        shakeCursor.enable = false;
        # slideBack.enable = false;
        # snapHelper.enable = false;
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
        number = 10;
        names = [
          "Desktop 1"
          "Desktop 2"
          "Desktop 3"
          "Desktop 4"
          "Desktop 5"
          "Desktop 6"
          "Desktop 7"
          "Desktop 8"
          "Desktop 9"
          "Desktop 10"
        ];
      };
    };

    overrideConfig = true;

    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      gwenviewrc.ThumbnailView.AutoplayVideos = true;
      kcminputrc.Keyboard.RepeatDelay = 400;

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
          "95d614da-6314-4bcd-9032-b5ea30c864cd" = "yast-kernel";
          "d3ec6d8f-3e27-451c-ac9a-f0370ee90c00" = "utilities-terminal";
        };
      };

      kdeglobals = {
        General = {
          BrowserApplication = "brave-browser.desktop";
        };
        # Icons = {
        #   Theme = "Tela-circle-dark";
        # };
        KDE = {
          AnimationDurationFactor = 1;
        };
      };

      klaunchrc.FeedbackStyle.BusyCursor = false;
      klipperrc.General.MaxClipItems = 100;

      kwinrc = {
        Plugins = {
          krohnkiteEnabled = true;
          diminactiveEnabled = true;
          # screenedgeEnabled = false;
        };
        # "Script-krohnkite" = {
        #   floatingClass = "brave-nngceckbapebfimnlniiiahkandclblb-Default,org.kde.kcalc";
        #   screenGapBetween = 6;
        #   screenGapBottom = 6;
        #   screenGapLeft = 6;
        #   screenGapRight = 6;
        #   screenGapTop = 6;
        # };
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
    dataFile = {
      "dolphin/view_properties/global/.directory"."Dolphin"."ViewMode" = 1;
      # "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" = true;
    };

    hotkeys.commands = {
      # Terminal
      launch-kitty = {
        name = "Launch Kitty";
        key = "Meta+Return";
        command = "kitty";
      };

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
        command = "brave --profile-directory=Default";
      };

      # Browser - Profile 1
      brave-profile1 = {
        name = "Brave Browser (Profile 1)";
        key = "Meta+;";
        command = "brave --profile-directory=\"Profile 1\"";
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
        "_launch" = "Meta+Space";
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

      kwin = {
        "Window Close" = "Meta+C";
        "Window Fullscreen" = "Meta+F";
        "Show Desktop" = [ ];
        "Toggle Tiles Editor" = [ ];

        KrohnkiteFocusLeft = "Meta+H";
        KrohnkiteFocusDown = "Meta+J";
        KrohnkiteFocusUp = "Meta+K";
        KrohnkiteFocusRight = "Meta+L";

        KrohnkiteShiftLeft = "Meta+Alt+H";
        KrohnkiteShiftDown = "Meta+Alt+J";
        KrohnkiteShiftUp = "Meta+Alt+K";
        KrohnkiteShiftRight = "Meta+Alt+L";

        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Switch to Desktop 10" = "Meta+0";

        # Move window to desktop shortcuts
        "Window to Desktop 1" = "Meta+Alt+1";
        "Window to Desktop 2" = "Meta+Alt+2";
        "Window to Desktop 3" = "Meta+Alt+3";
        "Window to Desktop 4" = "Meta+Alt+4";
        "Window to Desktop 5" = "Meta+Alt+5";
        "Window to Desktop 6" = "Meta+Alt+6";
        "Window to Desktop 7" = "Meta+Alt+7";
        "Window to Desktop 8" = "Meta+Alt+8";
        "Window to Desktop 9" = "Meta+Alt+9";
        "Window to Desktop 10" = "Meta+Alt+0";

        # Disable default zoom shortcuts to avoid conflicts
        "Zoom In" = "Meta+Ctrl+=";
        "Zoom Out" = "Meta+Ctrl+-";

        # Krohnkite resize shortcuts
        KrohnkiteIncreaseRatio = "Meta+Equal";
        KrohnkiteDecreaseRatio = "Meta+Minus";
        KrohnkiteIncrease = "Meta+Alt+Equal";
        KrohnkiteDecrease = "Meta+Alt+Minus";
      };
    };

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";
      iconTheme = "breeze-dark";
      cursorTheme = "breeze_cursors";

      enableMiddleClickPaste = false;
    };

    # kwin.nightColor = {
    #   enable = true;
    #   mode = "times";
    #   morning = "06:00";
    #   evening = "22:00";
    #   temperature = {
    #     day = 6500;
    #     night = 4500;
    #   };
    # };
  };
}
