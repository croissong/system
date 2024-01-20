{
  config,
  outputs,
  ...
}: {
  services = {
    kdeconnect.enable = true;

    spotifyd = {
      enable = true;
      settings = {
        global = {
          username = outputs.vars.spotify.username;
          password_cmd = "cat ${config.sops.secrets."spotify/password".path}";
          device_name = "nix";
          backend = "pulseaudio";
        };
      };
    };

    wlsunset = {
      enable = true;
      latitude = "51.3";
      longitude = "9.5";
      temperature.night = 2000;
    };

    pueue = {
      enable = true;
      settings = {
        shared = {};
      };
    };
  };
}
