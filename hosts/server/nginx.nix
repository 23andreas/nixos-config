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

        "syncthing.gafro.net" = proxy 8384 { };

        "glances.gafro.net" = proxy 61208 { };

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
