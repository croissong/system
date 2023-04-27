{inputs, pkgs, config, ...}: {
services = {
      fwupd = {
        enable = true;
        package = pkgs.fwupd.override {
          enableFlashrom = true;
          flashrom = config.programs.flashrom.package;
        };
        extraRemotes = ["lvfs-testing"];
      };
    };

    programs.flashrom = {
      enable = true;
      package = pkgs.flashrom;
    };
}
