{
  pkgs,
  lib,
  ...
}:

{
  services.thermald.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.intel-compute-runtime
      pkgs.vpl-gpu-rt
    ];
  };

  services.fstrim.enable = lib.mkDefault true;
}
