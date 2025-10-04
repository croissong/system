{ outputs, ... }:
{
  services = {
    fwupd.enable = true;

    flatpak.enable = true;
  };
}
