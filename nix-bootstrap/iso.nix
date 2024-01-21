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

  isoImage = {
    isoName = lib.mkDefault "nixos.iso";
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

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = "nix-command flakes";
      accept-flake-config = true;
    };
  };

  environment.shellAliases = {
    provision = "sudo /iso/provision.sh";
  };

  # just for console layout
  services.xserver = {
    layout = "de";
    xkbOptions = "ctrl:nocaps";
    xkbVariant = "nodeadkeys";
  };
  console.useXkbConfig = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Needed for https://github.com/NixOS/nixpkgs/issues/58959
    supportedFilesystems = lib.mkForce ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs"];
  };

  environment.systemPackages = with pkgs; [
    sops
    ouch
  ];
}
