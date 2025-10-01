{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  sops.templates."homelab-wg.nmconnection" = {
    owner = "root";
    group = "root";
    mode = "0600";
    content = ''
      [connection]
      id=Homelab WireGuard
      uuid=87654321-4321-8765-dcba-876543210987
      type=wireguard
      interface-name=wg0
      autoconnect=true

      [wireguard]
      private-key=${config.sops.placeholder."home-desktop/wireguard-private-key"}
      mtu=1300

      [wireguard-peer.Sl6SAm2yX3K8Kyxso8+JFYiENbGeNhS7YNYiMpAxUW4=]
      endpoint=server.lan:41526
      allowed-ips=10.8.0.0/24;

      [ipv4]
      address1=10.8.0.2/24
      method=manual

      [ipv6]
      method=ignore
    '';
  };

  environment.etc."NetworkManager/system-connections/homelab-wg.nmconnection".source =
    config.sops.templates."homelab-wg.nmconnection".path;
}
