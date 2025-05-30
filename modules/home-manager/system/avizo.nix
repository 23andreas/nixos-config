{ config, lib, ... }:

{
  config = lib.mkIf config.services.avizo.enable {
    services.avizo.settings = {
      default = {
        time = 0.5;
      };
    };
  };
}
