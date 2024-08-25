{ ... }:
let
  custom = {
    font = "SFProText Nerd Font";
    font_size = "14px";
    font_weight = "600";
    # text_color = "#cdd6f4";
    text_color = "@text";
    secondary_accent = "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "@base";
    opacity = "0.98";
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
        background: none;
        background: ${custom.background};
        opacity: 0.8;
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

    #workspaces button.empty {
        color: #6c7086;
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
      color: @base;
    }

    #tray {
      background-color: @surface0;
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
