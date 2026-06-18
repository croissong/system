{ pkgs, ... }:
{
  services = {
    fwupd = {
      enable = true;
      extraRemotes = [
        # "lvfs-testing"
      ];
    };
  };

  programs.flashrom = {
    enable = true;
  };
}
