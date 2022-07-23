{
  pkgs,
  modulesPath,
  lib,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  isoImage.contents = [
    {
      source = ./ansible;
      target = "ansible";
    }
    {
      source = ./config;
      target = "config";
    }
    {
      source = ./provision.sh;
      target = "provision.sh";
    }
  ];

  services.xserver.xkbOptions = "ctrl:swapcaps";
  console.useXkbConfig = true;

  services.openssh.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  environment.systemPackages = with pkgs; [
    ansible
    git
    spice-vdagent
  ];

  services.spice-vdagentd.enable = true;

  # from https://dataswamp.org/~solene/2022-05-20-nixos-thin-gaming-client.html
  isoImage.squashfsCompression = "zstd -Xcompression-level 6";

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs"];
}
