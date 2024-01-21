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

  programs.bash.shellInit = builtins.readFile ./bootstrap.sh;

  # just for console layout
  services.xserver = {
    layout = "de";
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
    ouch
  ];

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs"];
}
