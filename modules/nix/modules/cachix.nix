{ config, ... }:

let
  hostname = config.networking.hostName;
in
{
  services.cachix-agent = {
    enable = false;
    credentialsFile = config.sops.secrets."${hostname}/cachix-credentials-file".path;
  };
}
