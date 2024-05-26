{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      theme = "vscode";
      themes = {
        vscode = {
          fg = "#d4d4d4";
          bg = "#0A0A0A";
          black = "#1f1f1f";
          red = "#f44747";
          green = "#608b4e";
          yellow = "#dcdcaa";
          blue = "#569cd6";
          magenta = "#c678dd";
          cyan = "#56b6c2";
          white = "#d4d4d4";
          orange = "#cd7564";
        };
      };
    };
  };
}

