{...}: {
  services = {
    spotifyd = {
      enable = true;
      settings = {
        global = {
          username = "penatencremesuppe";
          password = "***REMOVED***";
          device_name = "nix";
          backend = "pulseaudio";
        };
      };
    };
  };
}
