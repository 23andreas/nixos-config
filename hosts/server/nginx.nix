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

    # appendHttpConfig = ''
    #   # Add HSTS header with preloading to HTTPS requests.
    #   # Adding this header to HTTP requests is discouraged
    #   map $scheme $hsts_header {
    #       https   "max-age=31536000; includeSubdomains; preload";
    #   }
    #   add_header Strict-Transport-Security $hsts_header;
    #
    #   # Enable CSP for your services.
    #   add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;
    #
    #   # Minimize information leaked to other domains
    #   add_header 'Referrer-Policy' 'origin-when-cross-origin';
    #
    #   # Disable embedding as a frame
    #   add_header X-Frame-Options DENY;
    #
    #   # Prevent injection of code in other mime types (XSS Attacks)
    #   add_header X-Content-Type-Options nosniff;
    #
    #   # This might create errors
    #   proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
    # '';
    #
    virtualHosts = let
      base = locations: {
        inherit locations;

        # forceSSL = true;
        # enableACME = true;

        basicAuth = {
          andreas = "test";
        };
      };

      proxy = port: base {
        "/".proxyPass = "http://127.0.0.1:" + toString port + "/";
      };
    in {
      "sonarr.gafro.net" = proxy 8989;
      "radarr.gafro.net" = proxy 7878;
      "bazarr.gafro.net" = proxy 6767;
      "prowlarr.gafro.net" = proxy 9696;

      "ha.gafro.net" = proxy 8123;

      "glances.gafro.net" = proxy 61208;

      "default_server" = {
        default = true;
        serverName = "_";  # Matches any requests not handled by other server blocks
        extraConfig = ''
          return 444;
        '';
      };
    };
  };

  networking.firewall = {
    enable = true;
    # TODO Remove glances port, only access through nginx
    allowedTCPPorts = [ 80 443 61208 19999 ];
  };

  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "andreas.skonberg@gmail.com";
  # };
}
