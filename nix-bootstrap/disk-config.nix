{disks ? ["/dev/vda"], ...}: let
  mountOptions = ["compress-force=zstd" "noatime" "discard=async"];
in {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              label = "ESP";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              label = "root";
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = "/tmp/luks-password.txt";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"]; # Override existing partition
                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                      mountOptions = mountOptions;
                    };
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
            };
          };
        };
      };
    };
  };
}
