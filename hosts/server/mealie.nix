{ config, pkgs, ... }:

{
  services.mealie = {
    enable = true;
    listenAddress = "127.0.0.1";
    port = 9925;

    settings = {
      # Database configuration
      # DB_ENGINE = "postgres";
      # POSTGRES_SERVER = "/run/postgresql";
      # # POSTGRES_PORT = "5432";
      # POSTGRES_DB = "mealie";
      # POSTGRES_USER = "mealie";
      # No password needed - using Unix socket with peer auth

      # Basic app settings
      BASE_URL = "https://mealie.garfro.net"; # Update with your domain
      API_PORT = "9925";

      # Security
      ALLOW_SIGNUP = "false"; # Set to true if you want open registration

      # Optional: Email settings (configure if needed)
      # SMTP_HOST = "";
      # SMTP_PORT = "587";
      # SMTP_FROM_NAME = "Mealie";
      # SMTP_FROM_EMAIL = "";
      # SMTP_USER = "";
      # SMTP_PASSWORD = "";
    };

    # Optional: Use credentialsFile for sensitive data
    # credentialsFile = config.sops.secrets."server/mealie-credentials".path;
  };

  # Ensure mealie user has access to database
  systemd.services.mealie = {
    after = [ "postgresql.service" ];
    wants = [ "postgresql.service" ];
  };
}
