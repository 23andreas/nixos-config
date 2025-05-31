{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    glances
  ];

  users.groups.glances = { };
  users.users.glances = {
    isSystemUser = true;
    description = "User for Glances service";
    group = "glances";
    home = "/var/lib/glances";
    shell = "/run/current-system/sw/bin/nologin";
  };

  # TODO Harden this
  systemd.services.glances = {
    description = "Glances monitoring tool";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.glances}/bin/glances -w";
      Restart = "on-failure";
      # Optionally, specify the user and group to run the service as
      User = "glances";
      Group = "glances";
    };
  };
}
