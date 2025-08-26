{
  config,
  lib,
  pkgs,
  ...
}:

let
  braveEnabled = config.programs.chromium.enable;
in
{

  config = lib.mkIf braveEnabled {
    programs.chromium = {
      package = pkgs.brave;
      commandLineArgs = [
        "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"

      ];
      extensions = [
        {
          # 1password
          id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";
        }
        {
          # React dev tools
          id = "fmkadmapgofadopljbjfkapdkoienihi";
        }
        # {
        # https://gitflic.ru/project/magnolia1234/bypass-paywalls-chrome-clean
        #   id = "aaa";
        #   updateUrl = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass-paywalls-chrome-clean-latest.crx"
        # }
      ];

    };
    #
    # xdg.mimeApps = {
    #   "x-scheme-handler/http" = "brave.desktop";
    #   "x-scheme-handler/https" = "brave.desktop";
    # };
  };
}
