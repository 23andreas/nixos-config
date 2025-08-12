{ pkgs, ... }:

{
  security.rtkit.enable = true;

  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;

      # used for rocksmith
      # https://github.com/theNizo/linux_rocksmith/blob/main/guides/setup/nixos/1.md
      jack.enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    pwvucontrol

    # Rocksmith
    qpwgraph # Lets you view pipewire graph and connect IOs
    pavucontrol # Lets you disable inputs/outputs, can help if game auto-connects to bad IOs
    unzip # Used by patch-nixos.sh
    rtaudio
  ];

  # Rocksmith configs
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }
  ];
}
