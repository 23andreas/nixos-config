{ pkgs, ... }:

{
  # To join this device to your Headscale network:"
  # 1. Run: sudo tailscale up --login-server=${config.services.tailscale-headscale.serverUrl}"
  # 2. Follow the URL provided to authorize this device"
  # 3. Or create a pre-auth key in Headscale and use: sudo tailscale up --login-server=${config.services.tailscale-headscale.serverUrl} --authkey=YOUR_KEY"

  environment.systemPackages = with pkgs; [
    tail-tray
  ];

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraSetFlags = [ "--operator=andreas" ];
  };

  systemd.user.services.tail-tray = {
    description = "Tail Tray";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.tail-tray}/bin/tail-tray";
      Restart = "on-failure";
    };
  };
}
