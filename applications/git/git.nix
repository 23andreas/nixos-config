{
  programs.git = {
    enable = true;
    userName = "Andreas Skønberg";
    userEmail = "andreas.skonberg@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      push = { autoSetupRemote = true; };
    };
  };
}

