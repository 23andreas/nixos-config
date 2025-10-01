{ pkgs, ... }:

{
  # PostgreSQL for n8n
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;

    # Create DB and user on activation
    ensureDatabases = [ "n8n" ];
    ensureUsers = [
      {
        name = "n8n";
        ensureDBOwnership = true;
        # Use a secret for password (recommended) or peer auth (see notes below)
        # Ensure this file contains: POSTGRES_N8N_PASSWORD="supersecret"
        # and is managed by sops-nix, then reference it below in the n8n service.
      }
    ];

    authentication = ''
      local all n8n peer
    '';

    settings = {
      # sensible defaults; tune as you like
      shared_buffers = "256MB";
      max_connections = 100;
    };
  };
}
