{
  lib,
  config,
  inputs,
  ...
}:

let
  cfg = config.nixosConfig.app.walker;
in
{
  options.nixosConfig.app.walker = {
    enable = lib.mkEnableOption "Walker";
  };

  imports = [
    inputs.walker.homeManagerModules.default
  ];

  config = lib.mkIf cfg.enable {
    programs.walker = {
      enable = true;
      runAsService = true;

      config = {
        builtins = {
          ai = {
            weight = 5;
            placeholder = "AIai";
            name = "ai";
            icon = "help-browser";
            switcher_only = true;
            anthropic = {
              model = "claude-3-5-sonnet-20241022";
              max_tokens = 1000;
              prompts = [
                {
                  label = "Text editor";
                  prompt = "You are an editor; edit this entire story for context, grammar, punctuation, formatting, and readability with explanation. Show the results in a table format with the original paragraph on the left and the suggested changes on the right.";
                }
              ];
            };
          };
        };
      };
    };
  };
}
