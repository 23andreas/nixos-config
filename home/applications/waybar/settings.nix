{ ... }:
{
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";
    # height= 5;

    modules-left = [
      "hyprland/workspaces"
      "tray"
    ];
    modules-center = [
      "clock"
      "privacy"
    ];
    modules-right = [
      # "cpu"
      # "memory"
      # "disk"
      "battery"
      "bluetooth"
      "network"
      "pulseaudio"
      "custom/notification"
    ];
    clock = {
      calendar = {
        format = { today = "<span color='#b4befe'><b><u>{}</u></b></span>"; };
      };
      format = "{:%a %B %d, %H:%M}";
      tooltip = "true";
      # tooltip-format= "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      tooltip-format = "{calendar}";
      format-alt = "{:%d.%m}";
    };
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = false;
      # format = "{icon}";
      on-click = "activate";
      # format-icons= {
      #     # "1"= "󰈹";
      #     # "2"= "";
      #     # "3"= "󰘙";
      #     # "4"= "󰙯";
      #     # "5"= "";
      #     # "6"= "";
      #     urgent= "";
      #     default = "";
      #     sort-by-number= true;
      # };
      # persistent-workspaces = {
      #     "1"= [];
      #     "2"= [];
      #     "3"= [];
      #     "4"= [];
      #     "5"= [];
      # };
    };
    memory = {
      format = "󰟜 {}%";
      format-alt = "󰟜 {used} GiB"; # 
      interval = 2;
    };
    cpu = {
      format = "  {usage}%";
      format-alt = "  {avg_frequency} GHz";
      interval = 2;
    };
    disk = {
      # path = "/";
      format = "󰋊 {percentage_used}%";
      interval = 60;
    };
    network = {
      format-wifi = "{icon}";
      format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
      format-ethernet = "";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "󰤭";
      on-click = "kitty nmtui";
    };
    tray = {
      icon-size = 14;
      spacing = 5;
    };
    pulseaudio = {
      format = "{icon}";
      format-muted = "󰸈";
      format-icons = [ "" "" "" ];
      # format-icons = {
      #   default = [ " " ];
      #
      # };
      scroll-step = 5;
      on-click = "pwvucontrol";
    };
    bluetooth = {
      format-off = "󰂲";
      format-on = "󰂯";
      format-connected = "󰂱";
      format = "";
      on-click = "blueberry";
      # "format-connected-battery": " {device_alias} {device_battery_percentage}%",
      # // "format-device-preference": [ "device1", "device2" ], // preference list deciding the displayed device
      # "tooltip-format": "{controller_alias}\t{controller_address}\n\n{num_connections} connected",
      # "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}",
      # "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}",
      # "tooltip-format-enumerate-connected-battery": "{device_alias}\t{device_address}\t{device_battery_percentage}%"
    };
    battery = {
      format = "{icon}";
      format-icons = [ " " " " " " " " " " ];
      format-charging = " {capacity}%";
      format-full = " {capacity}%";
      format-warning = " {capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };
    privacy = {
      icons-spacing = 5;
      icon-size = 14;
      modules = [
        {
          type = "screenshare";
          tooltip = true;
        }
        {
          type = "audio-in";
          tooltip = true;
        }
      ];
    };
    "custom/notification" = {
      tooltip = false;
      format = "{icon}";
      format-icons = {
        notification = "<span class=\"red\"><sup></sup></span>";
        none = "";
        dnd-notification = "<span class=\"red\"><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span class=\"red\"><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span class=\"red\"><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
  };
}
