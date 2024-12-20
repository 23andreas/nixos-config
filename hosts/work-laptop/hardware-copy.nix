{
  pkgs,
  lib,
  ...
}:

let
in
# hostname = "work-laptop";
{

  services.thermald.enable = true;

  # hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

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
