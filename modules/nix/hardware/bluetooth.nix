{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.blueberry
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}

