{ config, pkgs, lib, ... }:

{
  boot.initrd.kernelModules = [ "i915" ];

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  # nixpkgs.config.packageOverrides = pkgs: {
    # intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  # };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      intel-media-driver
      # intel-vaapi-driver
      intel-gmmlib
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {
    # LIBVA_DRIVER_NAME = "iHD";
    # VDPAU_DRIVER = "va_gl";
  };

  boot.kernelParams = [
    "i915.enable_guc=2"
  ];
}

