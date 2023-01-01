{disks ? ["/dev/sda"], ...}: let
  mountOptions = ["compress-force=zstd" "noatime" "discard=async"];
in {
  disk = {
    sda = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            type = "partition";
            name = "efi";
            start = "1MiB";
            end = "512MiB";
            fs-type = "fat32";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }
          {
            name = "root";
            type = "partition";
            start = "512MiB";
            end = "100%";
            content = {
              type = "luks";
              name = "crypted";
              content = {
                type = "btrfs";
                extraArgs = "-f"; # Override existing partition
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "@" = {
                    mountpoint = "/";
                    mountOptions = mountOptions;
                  };
                  # Mountpoints inferred from subvolume name
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = mountOptions;
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = mountOptions;
                  };
                  "@var_log" = {
                    mountpoint = "/var/log";
                    mountOptions = mountOptions;
                  };
                  "@var_cache" = {
                    mountpoint = "/var/cache";
                    mountOptions = mountOptions;
                  };
                  "@var_tmp" = {
                    mountpoint = "/var/tmp";
                    mountOptions = mountOptions;
                  };
                  "@snapshots" = {
                    mountpoint = "/.snapshots";
                    mountOptions = mountOptions;
                  };
                };
              };
            };
          }
        ];
      };
    };
  };
}
