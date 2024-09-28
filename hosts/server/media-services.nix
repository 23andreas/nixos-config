{ pkgs, ... }:

{
  users.groups.media = {};

  # https://github.com/NixOS/nixpkgs/pull/287923 :(
  environment.systemPackages = with pkgs; [
    qbittorrent-nox
  ];

  services = {
    plex = {
      enable = true;
      group = "media";
      # TODO pass in cpu for hw
      # accelerationDevices = ["*"];
    };
    sonarr = {
      enable = true;
      group = "media";
    };
    radarr = {
      enable = true;
      group = "media";
    };
    bazarr = {
      enable = true;
      group = "media";
    };
    prowlarr = {
      enable = true;
    };
  };
}

