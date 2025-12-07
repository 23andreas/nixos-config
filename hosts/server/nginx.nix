{ config, lib, ... }:

let
  hostname = config.networking.hostName;
in
{
  services.fail2ban = {
    enable = true;
    jails = {
      nginx-http-auth = {
        settings = {
          enabled = true;
          filter = "nginx-http-auth";
          maxretry = 3;
          findtime = 600;
          bantime = 3600;
        };
      };
      #   jellyfin = {
      #     settings = {
      #       enabled = true;
      #       port = "http,https";
      #       filter = "jellyfin";
      #       logpath = "/var/lib/jellyfin/log/log_*.log";
      #       maxretry = 3;
      #       findtime = 600;
      #       bantime = 3600;
      #     };
      #   };
    };
  };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;

    sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

    appendHttpConfig = ''
      # Add HSTS header with preloading to HTTPS requests.
      # Adding this header to HTTP requests is discouraged
      map $scheme $hsts_header {
          https   "max-age=31536000; includeSubdomains; preload";
      }
      add_header Strict-Transport-Security $hsts_header;

      # Enable CSP for your services.
      # add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;

      # Minimize information leaked to other domains
      add_header 'Referrer-Policy' 'origin-when-cross-origin';

      # Disable embedding as a frame
      add_header X-Frame-Options DENY;

      # Prevent injection of code in other mime types (XSS Attacks)
      add_header X-Content-Type-Options nosniff;

      # This might create errors
      proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
    '';

    virtualHosts =
      let
        base = locations: {
          inherit locations;
          forceSSL = true;
          enableACME = true;
          basicAuthFile = config.sops.secrets."${hostname}/nginx-andreas-basic-auth-file".path;
        };

        proxy =
          port: extraOptions:
          base (
            lib.recursiveUpdate {
              "/".proxyPass = "http://127.0.0.1:" + toString port + "/";
            } extraOptions
          );
      in
      {
        "default_server" = {
          default = true;
          serverName = "_"; # Matches any requests not handled by other server blocks
          extraConfig = ''
            return 444;
          '';
        };

        "sonarr.gafro.net" = proxy 8989 { };
        # "audiobookshelf.gafro.net" = proxy 8000 { };
        "radarr.gafro.net" = proxy 7878 { };
        "bazarr.gafro.net" = proxy 6767 { };
        "prowlarr.gafro.net" = proxy 9696 { };
        "qbittorrent.gafro.net" = proxy 7219 { };
        "tautulli.gafro.net" = proxy 8181 { };

        "jellyfin.gafro.net" = {
          forceSSL = true;
          enableACME = true;
          
          extraConfig = ''
            client_max_body_size 20M;
            # Override global cookie policy for Jellyfin
            proxy_cookie_path / "/; secure; HttpOnly; SameSite=lax";
          '';

          locations."/" = {
            proxyPass = "http://127.0.0.1:8096/";
            extraConfig = ''
              proxy_buffering off;
            '';
          };

          locations."/socket" = {
            proxyPass = "http://127.0.0.1:8096/socket";
            proxyWebsockets = true;
          };
        };

        "syncthing.gafro.net" = proxy 8384 { };

        "glances.gafro.net" = proxy 61208 { };

        "tailscale.gafro.net" = {
          forceSSL = true;
          enableACME = true;

          locations."/" = {
            proxyPass = "http://127.0.0.1:8080/";
            proxyWebsockets = true; # Enable WebSocket support for TS2021 protocol
            extraConfig = "auth_basic off;"; # Disable auth for all headscale endpoints
          };
        };

        "mealie.gafro.net" = {
          forceSSL = true;
          enableACME = true;

          extraConfig = ''
            client_max_body_size 0;
          '';

          locations."/" = {
            proxyPass = "http://127.0.0.1:9925/";
            proxyWebsockets = true;
            extraConfig = "auth_basic off;";
          };
        };

        # "n8n.gafro.net" = proxy 5678 { };
        "n8n.gafro.net" = {
          forceSSL = true;
          enableACME = true;

          # Keep your global basic auth file, but we'll disable it in specific locations below
          basicAuthFile = config.sops.secrets."${hostname}/nginx-andreas-basic-auth-file".path;

          # Per-vhost tweaks (override your global strict cookie path for n8n)
          extraConfig = ''
            proxy_read_timeout 600s;
            proxy_send_timeout 600s;
            client_max_body_size 50m;

            # Override global SameSite=strict which can break n8n auth flow
            proxy_cookie_path / "/; secure; HttpOnly; SameSite=lax";
          '';

          locations = {
            # UI (HTML) — Basic Auth applies here via server-level basicAuthFile
            "/" = {
              proxyPass = "http://127.0.0.1:5678/";
              proxyWebsockets = true;
            };

            # n8n API — NO Basic Auth (n8n handles session)
            "/rest/" = {
              proxyPass = "http://127.0.0.1:5678/rest/";
              proxyWebsockets = true;
              extraConfig = "auth_basic off;";
            };

            # WebSocket/SSE — NO Basic Auth
            "/socket.io/" = {
              proxyPass = "http://127.0.0.1:5678/socket.io/";
              proxyWebsockets = true;
              extraConfig = "auth_basic off;";
            };

            # Webhooks — must be public
            "/webhook/" = {
              proxyPass = "http://127.0.0.1:5678/webhook/";
              proxyWebsockets = true;
              extraConfig = "auth_basic off;";
            };
            "/webhook-test/" = {
              proxyPass = "http://127.0.0.1:5678/webhook-test/";
              proxyWebsockets = true;
              extraConfig = "auth_basic off;";
            };

            # Optional: health/metrics — NO Basic Auth
            "/healthz" = {
              proxyPass = "http://127.0.0.1:5678/healthz";
              extraConfig = "auth_basic off;";
            };
            "/metrics" = {
              proxyPass = "http://127.0.0.1:5678/metrics";
              extraConfig = "auth_basic off;";
            };
          };
        };

        # "ha.gafro.net" = {
        #   forceSSL = true;
        #   enableACME = true;
        #   extraConfig = ''
        #     proxy_buffering off;
        #   '';
        #   locations."/" = {
        #     proxyPass = "http://127.0.0.1:2164/";
        #     proxyWebsockets = true;
        #   };
        # };
      };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
    ];
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "andreas.skonberg@gmail.com";
    certs."gafro.net" = {
      dnsProvider = "cloudflare";
      domain = "*.gafro.net";
      environmentFile = config.sops.secrets."${hostname}/acme-cloudflare-environment-file".path;
    };
  };
}
