{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.bluedevil
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
