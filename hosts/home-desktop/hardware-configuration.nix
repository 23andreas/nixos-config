{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Fix for wifi disconnecting
  # Realtek RTL8922AE

  hardware.firmware = with pkgs; [ linux-firmware ];
  hardware.enableRedistributableFirmware = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };
  };

  # fileSystems = {
  #   "/" = {
  #     device = "/dev/disk/by-uuid/a1321626-dd8e-4bc1-9a7b-a8f0fbfbe16c";
  #     fsType = "ext4";
  #   };
  #
  #   "/boot" = {
  #     device = "/dev/disk/by-uuid/BC65-0215";
  #     fsType = "vfat";
  #   };
  # };
  #
  # swapDevices = [
  #   {
  #     device = "/dev/disk/by-uuid/1e47c0f0-d679-4beb-8c5d-dde9fef6992c";
  #   }
  # ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
