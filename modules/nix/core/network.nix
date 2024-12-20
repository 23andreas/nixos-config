{ config, lib, ... }:

let
  hostname = config._23andreas.hostname;
in
{
  options._23andreas.hostname = lib.mkOption {
    type = lib.types.str;
    description = "Hostname for the system.";
    default = null;
  };

  config = {
    assertions = [
      {
        assertion = hostname != null;
        message = "The option _23andreas.hostname must be set and cannot be null.";
      }
    ];
    networking = {
      hostName = hostname;
      networkmanager = {
        enable = true;
        # Fixes issues with wifi dropping out
        # wifi.powersave = false;
      };
      nameservers = [
        "1.1.1.1"
        "8.8.8.8"
      ];

      # firewall??
    };
  };
}
