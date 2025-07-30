{
  config,
  lib,
  outputs,
  ...
}:
{
  # don't auto start at boot
  systemd.user.services.keybase.Install.WantedBy = lib.mkForce [ ];

  services = {
    kdeconnect.enable = true;

    keybase.enable = true;

    spotifyd = {
      enable = true;
      settings = {
        global = {
          username = outputs.vars.spotify.username;
          password_cmd = "cat ${config.sops.secrets."spotify/password".path}";
          device_name = "nix";
          backend = "pulseaudio";
          initial_volume = "75";
        };
      };
    };

    pueue = {
      enable = true;
      settings = {
        shared = { };
      };
    };

    wob = {
      enable = true;
    };
  };
}
