{...}: let
  mountOptions = ["compress-force=zstd" "noatime" "discard=async"];
in {
  boot.initrd.luks.devices."crypted".device = "/dev/disk/by-partlabel/root";

  fileSystems = {
    "/" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@"] ++ mountOptions;
    };

    "/home" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@home"] ++ mountOptions;
    };

    "/nix" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@nix"] ++ mountOptions;
    };

    "/var/log" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@var_log"] ++ mountOptions;
      neededForBoot = true;
    };

    "/var/cache" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@var_cache"] ++ mountOptions;
    };

    "/var/tmp" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@var_tmp"] ++ mountOptions;
    };

    "/.snapshots" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@snapshots"] ++ mountOptions;
    };

    "/boot" = {
      device = "/dev/disk/by-partlabel/ESP";
      fsType = "vfat";
    };
  };
}
