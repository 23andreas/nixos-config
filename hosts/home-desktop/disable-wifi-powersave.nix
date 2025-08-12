{ pkgs, ... }:

{
  # This service runs once on boot to disable WiFi power saving.
  systemd.services.disable-wifi-power-management = {
    description = "Disable WiFi power management for the Realtek card";

    # This ensures the service runs when the system is ready.
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      # This is the exact command to run.
      ExecStart = "${pkgs.iw}/bin/iw dev wlan0 set power_save off";
    };
  };
}
