{ ... }:

# run this to identify
# for d in /sys/bus/usb/devices/3-1 /sys/bus/usb/devices/3-2 /sys/bus/usb/devices/3-4.3 /sys/bus/usb/devices/3-4.4; do
#  printf "%-8s  " "$(basename "$d")"
#  [ -f "$d/idVendor" ]  && v=$(cat "$d/idVendor")  || v="----"
#  [ -f "$d/idProduct" ] && p=$(cat "$d/idProduct") || p="----"
#  [ -f "$d/manufacturer" ] && m=$(cat "$d/manufacturer") || m=""
#  [ -f "$d/product" ]      && pr=$(cat "$d/product")      || pr=""
#  echo "$v:$p  $m $pr"

{
  systemd.services.disable-logitech-wakeup = {
    description = "Disable wakeup for Logitech USB Receiver";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/bin/sh -c 'echo disabled > /sys/bus/usb/devices/3-2/power/wakeup'";
    };
  };
}
