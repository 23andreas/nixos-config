{ config, lib, ... }:
let
  cfg = config.nixosConfig.app.kitty;
in
{
  options.nixosConfig.app.kitty = {
    enable = lib.mkEnableOption "Kitty";
    isDefaultTerminal = lib.mkOption {
      default = true;
      description = "Set Kitty as default terminal";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.TERMINAL = lib.mkIf cfg.isDefaultTerminal "kitty";

    programs.kitty = {
      enable = true;
      settings = {
        window_padding_width = 4;
        confirm_os_window_close = 0;
        background_opacity = " 0.9 ";
        background_blur = 60;

        # Dracula
        # foreground = "#f8f8f2";
        # background = "#0A0A0A";
        # selection_foreground = "#ffffff";
        # selection_background = "#44475a";
        #
        # url_color = "#8be9fd";
        #
        # # black
        # color0 = "#21222c";
        # color8 = "#6272a4";
        #
        # # red
        # color1 = "#ff5555";
        # color9 = "#ff6e6e";
        #
        # # green
        # color2 = "#50fa7b";
        # color10 = "#69ff94";
        #
        # # yellow
        # color3 = "#f1fa8c";
        # color11 = "#ffffa5";
        #
        # # blue
        # color4 = "#bd93f9";
        # color12 = "#d6acff";
        #
        # # magenta
        # color5 = "#ff79c6";
        # color13 = "#ff92df";
        #
        # # cyan
        # color6 = "#8be9fd";
        # color14 = "#a4ffff";
        #
        # # white
        # color7 = "#f8f8f2";
        # color15 = "#ffffff";
        #
        # # Cursor colors
        # cursor = "#f8f8f2";
        # cursor_text_color = "background";
        #
        # # Tab bar colors
        # active_tab_foreground = "#282a36";
        # active_tab_background = "#f8f8f2";
        # inactive_tab_foreground = "#282a36";
        # inactive_tab_background = "#6272a4";
        #
        # # Marks
        # mark1_foreground = "#282a36";
        # mark1_background = "#ff5555";
        #
        # # Splits/Windows
        # active_border_color = "#f8f8f2";
        # inactive_border_color = "#6272a4";

        # vscode dark color scheme for Kitty
        # By https://github/mofiqul

        foreground = "#d4d4d4";
        background = "#0A0A0A";
        selection_foreground = "#1f1f1f";
        selection_background = "#d7ba7d";
        url_color = "#0087BD";

        # black
        color0 = "#1f1f1f";
        color8 = "#808080";

        # red
        color1 = "#f44747";
        color9 = "#f44747";

        # green
        color2 = "#608b4e";
        color10 = "#608b4e";

        # yellow
        color3 = "#dcdcaa";
        color11 = "#dcdcaa";

        # blue
        color4 = "#569cd6";
        color12 = "#569cd6";

        # magenta
        color5 = "#c678dd";
        color13 = "#c678dd";

        # cyan
        color6 = "#56b6c2";
        color14 = "#56b6c2";

        # white
        color7 = "#d4d4d4";
        color15 = "#d4d4d4";
      };
    };
  };
}