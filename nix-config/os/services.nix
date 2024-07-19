{outputs, ...}: {
  services = {
    fwupd.enable = true;

    # TODO: maybe https://github.com/AdnanHodzic/auto-cpufreq
    # see https://nixos.wiki/wiki/Laptop
    tlp.enable = true;

    # https://nixos.wiki/wiki/Syncthing
    syncthing = {
      enable = true;
      user = "moi";
      dataDir = "/home/moi/dot";
      configDir = "/home/moi/.local/state/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = {
          "phone" = {id = outputs.vars.syncthing.phoneDeviceId;};
        };
        folders = {
          docs = {
            path = "~/dot/docs";
            devices = ["phone"];
          };
          notes = {
            path = "~/dot/notes";
            devices = ["phone"];
          };
          media = {
            path = "~/dot/media";
            devices = ["phone"];
          };
        };
      };
    };

    upower = {
      enable = true;
    };
  };
}
