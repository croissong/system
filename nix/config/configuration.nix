{ config, pkgs, ... }: {

  imports =
    [
      ./hardware-configuration.nix
    ];
  system.stateVersion = "22.11";

  boot.loader.systemd-boot.enable = true;

  services.xserver.xkbOptions = "ctrl:swapcaps";
  console.useXkbConfig = true;

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  environment.systemPackages = with pkgs; [
    ansible git spice-vdagent python310
  ];

  services.spice-vdagentd.enable = true;
}
