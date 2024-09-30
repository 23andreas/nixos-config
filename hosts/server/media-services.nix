{
  imports = [
    ../../modules/nix/modules/qbittorrent-nox.nix
    ../../modules/nix/modules/torrent-extractor.nix
  ];

  users.groups.media = {};

  networking.firewall.allowedTCPPorts = [ 7219 39603 ];
  services = {
    qbittorrent = let
      qbittorrentPort = 39603;
    in
    {
      enable = true;
      port = 7219;
      settings = {
        LegalNotice = {
          Accepted = true;
        };
        BitTorrent = {
          "Session\\PieceExtentAffinity" = true;
          "Session\\Port" = qbittorrentPort;
        };
        Preferences = {
          "Advanced\\AnonymousMode" = false;
          "Advanced\\osCache" = false;
          "Bittorrent\\Encryption" = 0;
          "Bittorrent\\LSD" = false;
          "Bittorrent\\MaxConnecs" = 10000;
          "Bittorrent\\MaxConnecsPerTorrent" = 1000;
          "Bittorrent\\MaxRatio" = 1000;
          "Bittorrent\\MaxUploads" = 1000;
          "Bittorrent\\MaxUploadsPerTorrent" = 100;
          "Connection\\GlobalUPLimit" = 8192;
          "Connection\\PortRangeMin" = qbittorrentPort;
          "Connection\\ResolvePeerCountries" = true;
          "Connection\\UPnP" = false;
          "Downloads\\SavePath" = "/media/torrent/downloads";
          "Downloads\\StartInPause" = false;
          "Downloads\\RunExternalProgramEnabled" = true;
          "Downloads\\RunExternalProgram" = "torrent-extractor \"%F\"";
          "Queueing\\MaxActiveDownloads" = 1;
          "Queueing\\MaxActiveTorrents" = 1000;
          "Queueing\\MaxActiveUploads" = 1000;
          "Queueing\\QueueingEnabled" = true;
          "WebUI\\AuthSubnetWhitelist" = "192.168.1.0/24";
          "WebUI\\AuthSubnetWhitelistEnabled" = true;
          "WebUI\\LocalHostAuth" = false;
          "WebUI\\Username" = "admin";
          "WebUI\\UseUPnP"= false;
          "WebUI\\Address" = "0.0.0.0";
        };
      };
      user = "qbittorrent";
      group = "media";
    };
    plex = {
      enable = true;
      group = "media";
      openFirewall = true;
      accelerationDevices = [ "/dev/dri/renderD128" ];
    };
    sonarr = {
      enable = true;
      group = "media";
      openFirewall = true;
    };
    radarr = {
      enable = true;
      group = "media";
      openFirewall = true;
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

