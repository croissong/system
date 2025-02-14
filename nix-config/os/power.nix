{ outputs, pkgs, ... }:
{
  services = {
    # TODO: maybe https://github.com/AdnanHodzic/auto-cpufreq
    # see https://nixos.wiki/wiki/Laptop
    tlp.enable = true;

    upower = {
      enable = true;
    };
  };
}
