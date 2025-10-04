{ outputs, ... }:
{
  services = {
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
  };
}
