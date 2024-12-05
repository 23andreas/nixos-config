{ config, pkgs, ... }:
{
  # Home assistant, 1400 sonos integration, zigbee2mqtt frontend
  networking.firewall.allowedTCPPorts = [
    2164 # Home assistant
    21064 # Homekit bridge
    1400 # Sonos?
    2916 # zigbee2mqtt
    10200 # wyoming piper
    10300 # wyoming whisper
    10700 # wyoming satellite
    10400 # wyoming open wake word
  ];
  systemd.tmpfiles.rules = [
    "f ${config.services.home-assistant.configDir}/automations.yaml 0755 hass hass"
    "f ${config.services.home-assistant.configDir}/scripts.yaml 0755 hass hass"
    "f ${config.services.home-assistant.configDir}/scenes.yaml 0755 hass hass"
  ];

  services = {
    wyoming = {
      # text to speech
      piper = {
        servers.yas = {
          enable = true;
          voice = "en-us-ryan-medium";
          uri = "tcp://0.0.0.0:10200";
        };
      };
      # satellite = {
      #   enable = true;
      #   name = "nixos satellite";
      #   user = "wyoming";
      #   uri = "tcp://0.0.0.0:10700";
      #   sounds.awake = builtins.fetchurl {
      #     url = "https://github.com/rhasspy/wyoming-satellite/raw/master/sounds/awake.wav";
      #     sha256 = "09076b8n30lxwaxpkyr6hm2j7xzv2ipgva9c49jphlzpp8mds9bb";
      #   };
      #   sounds.done = builtins.fetchurl {
      #     url = "https://github.com/rhasspy/wyoming-satellite/raw/master/sounds/done.wav";
      #     sha256 = "0ld9264nidcqxhvnc56gg3jyvpqsc2b2vb48kpx7f2l6z95r2p5w";
      #   };
      #   extraArgs = [
      #     "--debug"
      #     "--wake-word-name=ok_nabu"
      #     "--wake-uri=tcp://127.0.0.1:10400"
      #   ];
      # };      # openwakeword = {
      openwakeword = {
        enable = true;
        uri = "tcp://0.0.0:10400";
        preloadModels = [
          "alexa"
          # "ok_nabu"
        ];
        # extraArgs = [ "--debug" ];
      };
      faster-whisper = {
        servers.yas = {
          enable = true;
          device = "cpu";
          language = "no";
          model = "NbAiLab/nb-whisper-small";
          uri = "tcp://0.0.0.0:10300";
        };
      };
    };

    mosquitto = {
      enable = true;
      listeners = [
        {
          address = "localhost";
          acl = [ "pattern readwrite #" ];
          omitPasswordAuth = true;
          settings.allow_anonymous = true;
        }
      ];
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
        "elevenlabs"
        "todoist"
        "entur_public_transport"
        "homekit"
      ];

      customComponents = with pkgs.home-assistant-custom-components; [
        adaptive_lighting
      ];

      config = {
        sensor = [
          {
            platform = "entur_public_transport";
            stop_ids = [
              "NSR:StopPlace:6374"
            ];
          }
        ];
        # "automation manual" = [
        #   {
        #     alias = "Kjokken lys paa";
        #     trigger = {
        #       platform = "state";
        #       entity_id = "binary_sensor.bevegelsessensor_kjokken_occupancy";
        #       from = "off";
        #       to = "on";
        #     };
        #     action = {
        #       service = "light.turn_on";
        #       entity_id = "light.lys_kjokken";
        #     };
        #   }
        #   {
        #     alias = "Kjokken lys av";
        #     trigger = {
        #       platform = "state";
        #       entity_id = "binary_sensor.bevegelsessensor_kjokken_occupancy";
        #       from = "on";
        #       to = "off";
        #     };
        #     action = {
        #       service = "light.turn_off";
        #       entity_id = "light.lys_kjokken";
        #     };
        #   }
        # ];
        "automation ui" = "!include automations.yaml";
        "script ui" = "!include scripts.yaml";
        "scene ui" = "!include scenes.yaml";

        script = {
          stovsug_kjokken = {
            alias = "Støvsug kjøkken";
            sequence = [
              {
                data = {
                  command = "app_segment_clean";
                  params = [ 19 ];
                };
                entity_id = "vacuum.roborock_s8";
                service = "vacuum.send_command";
              }
            ];
            mode = "single";
          };
          stovsug_stue = {
            alias = "Støvsug stue";
            sequence = [
              {
                data = {
                  command = "app_segment_clean";
                  params = [ 16 ];
                };
                entity_id = "vacuum.roborock_s8";
                service = "vacuum.send_command";
              }
            ];
            mode = "single";
          };
          stovsug_soverom = {
            alias = "Støvsug soverom";
            sequence = [
              {
                data = {
                  command = "app_segment_clean";
                  params = [ 17 ];
                };
                entity_id = "vacuum.roborock_s8";
                service = "vacuum.send_command";
              }
            ];
            mode = "single";
          };
          stovsug_gang = {
            alias = "Støvsug gang";
            sequence = [
              {
                data = {
                  command = "app_segment_clean";
                  params = [ 18 ];
                };
                entity_id = "vacuum.roborock_s8";
                service = "vacuum.send_command";
              }
            ];
            mode = "single";
          };

          stovsug_kjokken_gang = {
            alias = "Støvsug kjøkken og gang";
            sequence = [
              {
                data = {
                  command = "app_segment_clean";
                  params = [
                    19
                    18
                  ];
                };
                entity_id = "vacuum.roborock_s8";
                service = "vacuum.send_command";
              }
            ];
            mode = "single";
          };
          stovsug_stue_soverom = {
            alias = "Støvsug stue og soverom";
            sequence = [
              {
                data = {
                  command = "app_segment_clean";
                  params = [
                    16
                    17
                  ];
                };
                entity_id = "vacuum.roborock_s8";
                service = "vacuum.send_command";
              }
            ];
            mode = "single";
          };
          stovsug_stue_kjokken_gang = {
            alias = "Støvsug stue, kjøkken og gang";
            sequence = [
              {
                data = {
                  command = "app_segment_clean";
                  params = [
                    19
                    18
                    16
                  ];
                };
                entity_id = "vacuum.roborock_s8";
                service = "vacuum.send_command";
              }
            ];
            mode = "single";
          };
        };

        homeassistant = {
          name = "Hjem";
          temperature_unit = "C";
          unit_system = "metric";
          time_zone = "Europe/Oslo";
        };

        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/default_config/
        default_config = { };

        http = {
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
