{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
  ];

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keys = [
    #home-desktop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICOZWSjNZelhP3CAaIrmLiMMeaTP6EqPz+m6WDVh1meX"
    #work-laptop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1bMDwYyT2X3vVJDe/tyM0+t1Q6eiiPO8JwuXLW1YcG"
  ];
}
