{ ... }:
{
  systemd.oomd = {
    enable = true;
    enableUserSlices = true;
  };
}
