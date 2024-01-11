{
  config,
  pkgs,
  ...
}: {
  environment.variables = {
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/tests/sway.nix#L29
    "WLR_RENDERER" = "pixman";

    # https://github.com/swaywm/wlroots/issues/3189
    "WLR_NO_HARDWARE_CURSORS" = "1";
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  environment.systemPackages = with pkgs; [
    spice-vdagent
    glxinfo
  ];

  imports = [
    # We need to import that to make it work.
    # <nixpkgs/nixos/modules/virtualisation/qemu-guest-agent.nix>
  ];

  # # https://discuss.linuxcontainers.org/t/install-lxd-agent-manually-on-custom-os/11826/2
  # systemd.services.lxd-agent-9p = {
  #   wantedBy = ["multi-user.target"];
  #   after = ["local-fs.target"];
  #   serviceConfig = {
  #     Type = "oneshot";
  #   };

  #   script = "mount -t 9p config /run/lxd_config/9p -o access=0,trans=virtio || exit 0";
  #   preStart = ''
  #     /run/current-system/sw/bin/modprobe 9pnet_virtio
  #     mkdir -p /run/lxd_config/9p
  #     chmod 0700 /run/lxd_config/
  #   '';

  #   path = with pkgs; [
  #     kmod
  #     mount
  #     # chmod
  #   ];
  # };

  # systemd.services.lxd-agent = {
  #   wantedBy = ["multi-user.target"];
  #   after = ["lxd-agent-9p.service"];
  #   unitConfig = {
  #     Requires = "lxd-agent-9p.service";
  #   };

  #   serviceConfig = {
  #     Type = "simple";
  #     WorkingDirectory = "/run/lxd_config/9p";
  #   };

  #   script = "/run/lxd_config/9p/lxd-agent";

  #   path = with pkgs; [mount];
  # };

  virtualisation.lxd.agent.enable = true;
}
