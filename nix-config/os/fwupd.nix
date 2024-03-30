{pkgs, ...}: {
  services = {
    fwupd = {
      enable = true;
      package = pkgs.fwupd.override {
        enableFlashrom = true;
      };
      extraRemotes = [
        # "lvfs-testing"
      ];
    };
  };

  programs.flashrom = {
    enable = true;
    package = pkgs.flashrom;
  };
}
