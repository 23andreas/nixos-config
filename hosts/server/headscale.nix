{ config, ... }:
let
  hostname = config.networking.hostName;
in
{
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

      # DERP configuration (use Tailscale's DERP servers)
      derp = {
        urls = [
          "https://controlplane.tailscale.com/derpmap/default"
        ];
        auto_update_enabled = true;
        update_frequency = "24h";
      };
    };
  };

  # Database configuration moved to postgresql.nix

  # Open firewall for metrics (optional)
  # networking.firewall.allowedTCPPorts = [ 9090 ];
}
