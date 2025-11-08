{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 8080;

    settings = {
      server_url = "https://tailscale.gafro.net";
      # listen_addr = "127.0.0.1:8080";
      # metrics_listen_addr = "127.0.0.1:9090";

      # Use existing PostgreSQL database via Unix socket
      # database_url = "postgresql://headscale@/headscale?host=/run/postgresql&sslmode=disable";

      # Basic configuration
      # ephemeral_node_inactivity_timeout = "30m";
      # node_update_check_interval = "10s";

      # IP prefixes for the tailnet
      ip_prefixes = [
        "100.64.0.0/10"
      ];
      #
      # DNS configuration
      dns = {
        override_local_dns = false;
        nameservers.global = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        domains = [ "gafro.net" ];
        magic_dns = true;
        base_domain = "tailscale.gafro";
      };

      # Disable telemetry
      disable_check_updates = true;

      # OIDC/OAuth settings (disabled for now)
      # oidc = {
      #   issuer = "";
      #   client_id = "";
      #   client_secret = "";
      # };

      # Log configuration
      # log_level = "info";

      # DERP configuration with embedded DERP server
      derp = {
        # Keep Tailscale's public DERP servers as fallback
        # Once your embedded DERP is working well, you can set urls = [] for complete privacy
        urls = [
          "https://controlplane.tailscale.com/derpmap/default"
        ];
        auto_update_enabled = true;
        update_frequency = "24h";

        # Embedded DERP server configuration
        server = {
          enabled = true;
          region_id = 999;
          region_code = "gafro";
          region_name = "Gafro DERP Server";
          stun_listen_addr = "0.0.0.0:3478";

          # Using your public IP (note: update if IP changes, or use DNS hostname)
          ipv4 = "193.91.129.32";
          # ipv6 = "YOUR_IPV6_HERE";  # Add if you have IPv6

          # Only allow your authenticated Headscale clients to use this DERP
          verify_clients = true;

          # Automatically add this DERP region to the map
          automatically_add_embedded_derp_region = true;

          # Private key will be auto-generated at this path
          private_key_path = "/var/lib/headscale/derp_server_private.key";
        };
      };
    };
  };

  networking.firewall.allowedUDPPorts = [
    41641
    3478
  ];
}
