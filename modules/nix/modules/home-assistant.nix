{ config, pkgs, ...}:
{
  # Home assistant, 1400 sonos integration, zigbee2mqtt frontend
  networking.firewall.allowedTCPPorts = [ 2164 1400 2916 ];
  systemd.tmpfiles.rules = [
    "f ${config.services.home-assistant.configDir}/automations.yaml 0755 hass hass"
    "f ${config.services.home-assistant.configDir}/scripts.yaml 0755 hass hass"
  ];
  services = {

    mosquitto = {
      enable = true;
      listeners = [
        {
          acl = [ "pattern readwrite #" ];
          omitPasswordAuth = true;
          settings.allow_anonymous = true;
        }
      ];
      # listeners = [
      #   {
      #     users.ha = {
      #       acl = [
      #         "readwrite #"
      #       ];
      #       # Generated with this command
      #       # nix shell nixpkgs#mosquitto --command mosquitto_passwd -c /tmp/passwd ha
      #       hashedPassword = "$7$101$P/+2fSwh3cS76EQq$mBuHiIwD4dAIeRVhux3TghqbOxVJK3HjEx7qO94XjTdORH/rXZoHqDPLKaHSFISJa2SoCMcBRvJfbjhmgJyg9g==";
      #     };
      #   }
      # ];
    };

    zigbee2mqtt = {
      enable = true;
      settings = {
        frontend = {
          port = 2916;
          host = "0.0.0.0";
        };
        homeassistant = config.services.home-assistant.enable;
        permit_join = false;
        mqtt = {
          server = "mqtt://localhost:1883";
          # user = "'!${config.sops.secrets."${config._23andreas.hostname}/mqtt_secrets".path} user";
          # password = "'!${config.sops.secrets."${config._23andreas.hostname}/mqtt_secrets".path} password";
        };
        serial = {
          port = "/dev/ttyUSB0";
        };
      };
    };

    home-assistant = {
      enable = true;
      extraComponents = [
        # Components required to complete the onboarding
        "default_config"
        "met"
        "esphome"
        "radio_browser"
        "hunterdouglas_powerview"
        "zha"
        "homekit_controller"
        "apple_tv"
        "sonos"
        "spotify"
        "androidtv_remote"
        "cast"
        "isal"
        "samsungtv"
        "google_translate"
        "mqtt"
        "mill"
        "tibber"
        "roborock"
        "openai_conversation"
        "whisper"
        "wyoming"
        "workday"
      ];

      customComponents = with pkgs.home-assistant-custom-components; [
        adaptive_lighting
      ];

      config = {
        "automation manual" = [
          {
            alias = "Kjokken lys paa";
            trigger = {
              platform = "state";
              entity_id = "binary_sensor.bevegelsessensor_kjokken_occupancy";
              from = "off";
              to = "on";
            };
            action = {
              service = "light.turn_on";
              entity_id = "light.lys_kjokken";
            };
          }
          {
            alias = "Kjokken lys av";
            trigger = {
              platform = "state";
              entity_id = "binary_sensor.bevegelsessensor_kjokken_occupancy";
              from = "on";
              to = "off";
            };
            action = {
              service = "light.turn_off";
              entity_id = "light.lys_kjokken";
            };
          }
        ];
        "automation ui" = "!include automations.yaml";
        "script ui" = "!include scripts.yaml";

        homeassistant = {
          name = "Hjem";
          unit_system = "metric";
          time_zone = "UTC";
        };

        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/default_config/
        default_config = {};

        http = {
          # server_host = "0.0.0.0";
          server_port = 2164;
          use_x_forwarded_for = true;
          trusted_proxies = [
            "127.0.0.1"
            "192.168.1.0/24"
          ];
          ip_ban_enabled = true;
          login_attempts_threshold = 3;
        };
      };
    };
  };
}
