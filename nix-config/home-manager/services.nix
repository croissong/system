{
  config,
  outputs,
  ...
}: {
  services = {
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
  };
}
