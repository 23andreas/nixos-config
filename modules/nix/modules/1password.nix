{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gtk3 ];
  # Packages
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # polkitPolicyOwners = [ "andreas" ];
  };
}

