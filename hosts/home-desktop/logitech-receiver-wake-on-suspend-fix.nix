{ ... }:

{
  systemd.services.disable-logitech-wakeup = {
    description = "Disable wakeup for Logitech USB Receiver";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/bin/sh -c 'echo disabled > /sys/bus/usb/devices/3-8/power/wakeup'";
    };
  };
}
