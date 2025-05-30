{ config, lib, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        scanRandMacAddress = true;
        backend = "iwd";
        macAddress = "random";
      };
    };

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}
