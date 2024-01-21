{...}: {
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    fwupd.enable = true;

    # TODO: use nixos services + declarative config
    # https://nixos.wiki/wiki/Syncthing
    # syncthing = {
    #   enable = true;
    # };
  };
}
