{ ... }:

let
  custom = {
    font = "SFProText Nerd Font";
    font_size = "14px";
    font_weight = "600";
    secondary_accent = "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "rgba(36, 39, 58, 0.8)";
    tray = "rgba(36, 39, 58, 0.5)";
    opacity = "0.9";
  };
in
{
  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 0px;
        min-height: 0px;
        font-family: ${custom.font};
        font-weight: ${custom.font_weight};
    }

    window#waybar {
        background: ${custom.background};
    }

    window#waybar>box {
      padding: 0px 10px;
    }

    #workspaces {
        font-size: ${custom.font_size};
        padding-left: 0px;

    }

    #workspaces button {
        color: @overlay1;
        padding-left:  0px;
        padding-right: 0px;
    }

    #workspaces button:hover {
        background-image: none;
        text-shadow: none;
        box-shadow: none;
        color: @subtext0;
    }

    #workspaces button.empty {
        color: @subtext1
    }

    #workspaces button.active {
        color: @text;
    }

    #tray, #submap, #pulseaudio, #bluetooth, #network, #cpu, #memory, #disk, #clock, #battery, #custom-notification, #privacy {
        font-size: ${custom.font_size};
        color: @text;
        margin-left: 5px;
    }

    #submap {
      background-color: @red;
      padding: 0px 10px;
      color: ${custom.background};
    }

    #tray {
      background-color: ${custom.tray};
      padding: 0px 5px;
      margin-left: 10px;
    }

    #privacy {
      color: @yellow;
    }

    span.red {
      color: @red;
    }
  '';
}
