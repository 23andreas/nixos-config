{ config, lib, ... }:
let
  cfg = config.nixosConfig.app.kitty;
in
{
  options.nixosConfig.app.kitty = {
    enable = lib.mkEnableOption "Kitty";
    isDefaultTerminal = lib.mkOption {
      default = false;
      description = "Set Kitty as default terminal";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.TERMINAL = lib.mkIf cfg.isDefaultTerminal "kitty";

    catppuccin.kitty = {
      enable = true;
      flavor = "mocha";
    };

    programs.kitty = {
      enable = true;

      settings = {
        # window_padding_width = 4;
        confirm_os_window_close = 0;
        placement_strategy = "top";
        # background = "#1d2129";
        # background = "#151B23";
        background = "#1F2733";
        # background_opacity = "0.97";
        # background_blur = 60;
        font_size = "10.8";
        # modify_font = "cell_height 110%";

        cursor_trail = 1;
        cursor_trail_decay = "0.1 0.3";
      };
      shellIntegration.enableFishIntegration = true;
    };
  };

  # # Write the kitten script directly here
  # home.file.".config/kitty/toggle_background_opacity.py".text = ''
  #   def handle_result(args, answer, target_window_id, boss):
  #      import kitty.fast_data_types as f
  #      os_window_id = f.current_focused_os_window_id()
  #      current_opacity = f.background_opacity_of(os_window_id)
  #      boss.set_background_opacity("default" if current_opacity == whatever else whatever)
  # '';
}
