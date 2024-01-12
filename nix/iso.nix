# https://github.com/nix-community/nixos-generators
{
  pkgs,
  lib,
  ...
}: {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ../nix-config/nixos/vm.nix
  ];

  # put under /iso/
  isoImage.contents = [
    {
      source = /home/croissong/System;
      target = "system";
    }
    {
      source = /home/croissong/.config/age/identity.age;
      target = "age-keys.txt";
    }
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # just for console layout
  services.xserver = {
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    xkbVariant = "nodeadkeys";
  };
  console.useXkbConfig = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  environment.systemPackages = with pkgs; [
    lsof
    util-linux
    git
    sops
  ];

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs"];
}
