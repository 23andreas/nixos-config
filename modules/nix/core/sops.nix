{ inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    age.sshKeyPaths = [
      "/var/lib/sops-nix/nixos-config-key"
    ];
    # secrets = {
    #   "users/andreas/hashed_password".neededForUsers = true;
    #   wireless_env = { };
    #   "home-desktop/cachix-credentials-file" = { };
    # };
  };
}
