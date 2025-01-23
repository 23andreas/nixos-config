{ config, ... }:

let
  hostname = config._23andreas.hostname;
in
{
  services.cachix-agent = {
    enable = false;
    credentialsFile = config.sops.secrets."${hostname}/cachix-credentials-file".path;
  };
}
