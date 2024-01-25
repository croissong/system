# https://github.com/nix-community/nixos-generators
{
  pkgs,
  lib,
  ...
}: {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ../nix-config/nixos/base.nix
    ../nix-config/nixos/boot.nix
    # TODO: if not VM
    ../nix-config/nixos/network.nix
    ../nix-config/nixos/nix.nix
  ];

  isoImage = {
    isoName = lib.mkDefault "nixos.iso";
    # isoName = lib.mkForce "nixos.iso";
    squashfsCompression = "gzip -Xcompression-level 1";

    # put under /iso/
    contents = [
      {
        source = ./provision.sh;
        target = "provision.sh";
      }
      {
        source = ../iso-contents.tar.sz;
        target = "iso-contents.tar.sz";
      }
    ];
  };

  environment.shellAliases = {
    provision = "sudo /iso/provision.sh";
  };

  networking.wireless.enable = false;

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs"];

  environment.systemPackages = with pkgs; [
    sops
    ouch
  ];
}
