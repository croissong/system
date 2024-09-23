{ outputs, pkgs, ... }:
{
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
          "phone" = {
            id = outputs.vars.syncthing.phoneDeviceId;
          };
        };
        folders = {
          docs = {
            path = "~/dot/docs";
            devices = [ "phone" ];
          };
          notes = {
            path = "~/dot/notes";
            devices = [ "phone" ];
          };
          media = {
            path = "~/dot/media";
            devices = [ "phone" ];
          };
          cam = {
            path = "~/dot/cam";
            devices = [ "phone" ];
          };
          voice = {
            path = "~/dot/voice";
            devices = [ "phone" ];
          };
        };
      };
    };

    upower = {
      enable = true;
    };
  };

  systemd.services.keyboard-chattering-fix = {
    description = "A tool for blocking mechanical keyboard chattering on Linux";
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.keyboard-chattering-fix}/bin/keyboard-chattering-fix --threshold 50";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
