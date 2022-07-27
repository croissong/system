{
  config,
  pkgs,
  modulesPath,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # modprobe
  ];
  virtualisation.lxd.enable = true;
  # https://discuss.linuxcontainers.org/t/install-lxd-agent-manually-on-custom-os/11826/2

  systemd.services.lxd-agent-9p = {
    wantedBy = ["multi-user.target"];
    after = ["local-fs.target"];
    serviceConfig = {
      Type = "oneshot";
    };

    script = "mount -t 9p config /run/lxd_config/9p -o access=0,trans=virtio";
    preStart = ''
      /run/current-system/sw/bin/modprobe 9pnet_virtio
      mkdir -p /run/lxd_config/9p
      chmod 0700 /run/lxd_config/
    '';

    path = with pkgs; [
      # Not working (in iso)?
      # config.system.sbin.modprobe
      kmod
      mount
      # chmod
    ];
  };

  systemd.services.lxd-agent = {
    wantedBy = ["multi-user.target"];
    after = ["lxd-agent-9p.service"];
    unitConfig = {
      Requires = "lxd-agent-9p.service";
    };

    serviceConfig = {
      Type = "simple";
      WorkingDirectory = "/run/lxd_config/9p";
    };

    script = "/run/lxd_config/9p/lxd-agent";

    path = with pkgs; [mount];
  };

  # systemd.services.lxd-agent = {
  #   enable = true;
  #   script = "lxd-agent";
  #   path = with pkgs; [
  #     lxd
  #     # https://github.com/stevenewey/lxd-vms-on-nixos/blob/master/etc/nixos/lxd-agent.nix
  #     (stdenv.mkDerivation buildGoPackage rec {
  #       name = "lxd-agent";
  #       version = "5.4"; # modify the version if using newer LXD

  #       goPackagePath = "github.com/lxc/lxd";

  #       ldflags = ["-extldflags=-static" "-s" "-w"];
  #       tags = ["libsqlite3"];

  #       src = fetchurl {
  #         url = "https://github.com/lxc/lxd/releases/download/lxd-${version}/lxd-${version}.tar.gz";
  #         sha256 = "sha256-4jS2fFB30F4i+VjjJWvZHyYkUFRZk9Cq8bTOK9uZOTo="; # update this when changing LXD version
  #       };

  #       subPackages = ["lxd-agent"];

  #       preConfigure = ''
  #         export CGO_ENABLED=0
  #       '';

  #       postPatch = ''
  #         substituteInPlace shared/usbid/load.go \
  #           --replace "/usr/share/misc/usb.ids" "${hwdata}/share/hwdata/usb.ids"
  #       '';

  #       # preBuild = ''
  #       #   # unpack vendor
  #       #   pushd go/src/github.com/lxc/lxd
  #       #   rm _dist/src/github.com/lxc/lxd
  #       #   cp -r _dist/src/* ../../..
  #       #   popd
  #       # '';
  #     })
  #   ];
  # };
}
