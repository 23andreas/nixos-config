{ config, ... }:
{
  # Simple WireGuard server - no IP forwarding or NAT needed
  networking.firewall.allowedUDPPorts = [ 41526 ];
  networking.useNetworkd = true;

  systemd.services.systemd-networkd.serviceConfig.LoadCredential = [
    "network.wireguard.private.10-wg0:${config.sops.secrets."server/wireguard-private-key".path}"
  ];

  systemd.network = {
    enable = true;

    networks.wg0 = {
      matchConfig.Name = "wg0";
      address = [
        "10.8.0.1/24"
      ];
      networkConfig = {
        IPMasquerade = "ipv4";
        IPv4Forwarding = true;
      };
    };

    netdevs."10-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
        MTUBytes = "1300";
      };
      wireguardConfig = {
        ListenPort = 41526;
      };
      wireguardPeers = [
        {
          # home-desktop
          PublicKey = "yNaA29EUmQc/dLqhc6jOqZ8pkZuygPeNXvQHymk7Nhc=";
          AllowedIPs = [ "10.8.0.2/32" ];
        }
        # laptop
        {
          PublicKey = "2Xv4drfsqJLLs4DA1KFz0rW79DZ839Pdmkbx7OAEp2g=";
          AllowedIPs = [ "10.8.0.3/32" ];
        }
      ];
    };
  };
}
