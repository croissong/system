{
  config,
  pkgs,
  modulesPath,
  lib,
  ...
}: {
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
}
