{...}: {
  # https://nixos.wiki/wiki/PipeWire
  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}
