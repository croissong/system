# https://nixos.org/manual/nixos/stable/options.html
# https://search.nixos.org/options
# https://github.com/Misterio77/nix-starter-configs
{
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  imports = [
    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    ./base.nix
    ./boot.nix
    ./env.nix
    ./fonts.nix
    ./fs.nix
    ./fwupd.nix
    ./hardware.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./pkgs.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./sound.nix
    ./users.nix
    ./virtualisation.nix

    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  system.stateVersion = "23.11";

  sops = {
    defaultSopsFile = ../secrets.yaml;
    age.keyFile = "/etc/age/identity.age";
    secrets = {
      hashedPassword = {};
    };
  };
}
