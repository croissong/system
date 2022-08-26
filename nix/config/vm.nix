{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./vm-lxd-agent.nix
  ];

  virtualisation.lxd.enable = true;
  # networking.interfaces.enp4s0.useDHCP = true;

  # TODO
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;
}
