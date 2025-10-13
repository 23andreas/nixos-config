{ config, ... }:

{
  services.mealie = {
    enable = true;
    listenAddress = "127.0.0.1";
    port = 9925;

    settings = {
      # Database configuration - using SQLite for simplicity
      DB_ENGINE = "sqlite";

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

      # OPENAI_MODEL = "gpt-4o"; # or "gpt-3.5-turbo"
      OPENAI_ENABLE_IMAGE_SERVICES = "false";
      OPENAI_WORKERS = 1;
    };

    # Optional: Use credentialsFile for sensitive data
    credentialsFile = config.sops.secrets."server/mealie-credentials".path;
  };

  # Ensure mealie user has access to database
  systemd.services.mealie = {
    after = [ "postgresql.service" ];
    wants = [ "postgresql.service" ];
  };
}
