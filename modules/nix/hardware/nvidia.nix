{ config, pkgs, ... }:

{
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelModules = [
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
  ];

  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
    "nvidia-drm.modeset=1"
    "module_blacklist=i915"
  ];

  boot.extraModprobeConfig = ''
    options nvidia-drm fbdev=1
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    options nvidia NVreg_TemporaryFilePath=/var/tmp
  '';

  hardware.graphics = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    egl-wayland
    mesa
    libglvnd
    libGL

    libva-utils
    # vdpauinfo

    vulkan-tools
    vulkan-loader
    # vulkan-validation-layers

    libvdpau-va-gl
    wgpu-utils
    nvtopPackages.full
    libGL
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.sessionVariables = {
    # LIBVA_DRIVER_NAME = "nvidia";

    # VDPAU_DRIVER = "nvidia";
    # GBM_BACKEND = "nvidia";

    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # NVD_BACKEND = "direct"; #NVIDIA video acceleration
  };

  hardware.nvidia = {
    # forceFullCompositionPipeline = true;
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = false;

    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;

    # package =
    #   # let
    #   #   rcu_patch = pkgs.fetchpatch {
    #   #     url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
    #   #     hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
    #   #   };
    #   # in
    #   config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #     version = "555.42.02";
    #     sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
    #     sha256_aarch64 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
    #     openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
    #     settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
    #     persistencedSha256 = lib.fakeSha256;
    #
    #     # version = "535.154.05";
    #     # sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
    #     # sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
    #     # openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
    #     # settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
    #     # persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";
    #
    #     #   version = "545.29.06";
    #     #   sha256_64bit = "sha256-grxVZ2rdQ0FsFG5wxiTI3GrxbMBMcjhoDFajDgBFsXs=";
    #     #   sha256_aarch64 = "sha256-o6ZSjM4gHcotFe+nhFTePPlXm0+RFf64dSIDt+RmeeQ=";
    #     #   openSha256 = "sha256-h4CxaU7EYvBYVbbdjiixBhKf096LyatU6/V6CeY9NKE=";
    #     #   settingsSha256 = "sha256-YBaKpRQWSdXG8Usev8s3GYHCPqL8PpJeF6gpa2droWY=";
    #     #   persistencedSha256 = "sha256-AiYrrOgMagIixu3Ss2rePdoL24CKORFvzgZY3jlNbwM=";
    #
    #     # patches = [ rcu_patch ];
    #   };
  };
}
