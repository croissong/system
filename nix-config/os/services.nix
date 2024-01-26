{...}: {
  services = {
    fwupd.enable = true;

    # TODO: maybe https://github.com/AdnanHodzic/auto-cpufreq
    # see https://nixos.wiki/wiki/Laptop
    tlp.enable = true;

    # TODO: use nixos services + declarative config
    # https://nixos.wiki/wiki/Syncthing
    # syncthing = {
    #   enable = true;
    # };

    upower = {
      enable = true;
    };
  };
}
