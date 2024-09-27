{
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
      add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;

      # Minimize information leaked to other domains
      add_header 'Referrer-Policy' 'origin-when-cross-origin';

      # Disable embedding as a frame
      add_header X-Frame-Options DENY;

      # Prevent injection of code in other mime types (XSS Attacks)
      add_header X-Content-Type-Options nosniff;

      # This might create errors
      proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
    '';

    virtualHosts = let
      base = locations: {
        inherit locations;

        forceSSL = true;
        enableACME = true;
      };
      proxy = port: base {
        "/".proxyPass = "http://127.0.0.1:" + toString port + "/";
      };
    in {
      # Define example.com as reverse-proxied service on 127.0.0.1:3000
      "sonarr.gafro.net" = proxy 8989 // { default = true; };
      "radarr.gafro.net" = proxy 7878 // { default = true; };
      "bazarr.gafro.net" = proxy 6767 // { default = true; };
      "prowlarr.gafro.net" = proxy 9696 // { default = true; };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "andreas.skonberg@gmail.com";
  };
}
