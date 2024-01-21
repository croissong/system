{...}: {
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    fwupd.enable = true;

    # TODO: maybe https://github.com/AdnanHodzic/auto-cpufreq
    # see https://nixos.wiki/wiki/Laptop
    tlp.enable = true;

    # TODO: use nixos services + declarative config
    # https://nixos.wiki/wiki/Syncthing
    # syncthing = {
    #   enable = true;
    # };
  };
}
