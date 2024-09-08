{
  programs.fish.enable = true;

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.navi = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
}

