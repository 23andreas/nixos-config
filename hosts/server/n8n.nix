{
  services.n8n = {
    enable = true;
    openFirewall = true;

    environment = {
      N8N_HOST = "n8n.gafro.net";
      N8N_PORT = "5678";
      N8N_PROTOCOL = "https";
      N8N_SECURE_COOKIE = "true";

      DB_TYPE = "postgresdb";
      DB_POSTGRESDB_HOST = "/run/postgresql";
      DB_POSTGRESDB_DATABASE = "n8n";
      DB_POSTGRESDB_USER = "n8n";

      GENERIC_TIMEZONE = "Europe/Oslo";

      N8N_PROXY_HOPS = "1";

      WEBHOOK_URL = "https://n8n.gafro.net/";
    };
  };
}
