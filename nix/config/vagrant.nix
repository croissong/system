{
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./vagrant-hostname.nix
    # ./vagrant-network.nix
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu;
  # networking.interfaces.enp4s0.useDHCP = true;

  services.spice-vdagentd.enable = true;
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  services.qemuGuest.enable = true;
}
