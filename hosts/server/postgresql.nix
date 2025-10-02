{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;

    ensureDatabases = [
      "n8n"
      "mealie"
      "headscale"
    ];
    ensureUsers = [
      {
        name = "n8n";
        ensureDBOwnership = true;
      }
      {
        name = "mealie";
        ensureDBOwnership = true;
      }
      {
        name = "headscale";
        ensureDBOwnership = true;
      }
    ];

    authentication = ''
      local all n8n peer
      local all mealie peer
      local all headscale peer
    '';

    settings = {
      # sensible defaults; tune as you like
      shared_buffers = "256MB";
      max_connections = 100;
    };
  };
}
