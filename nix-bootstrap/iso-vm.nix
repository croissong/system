{lib, ...}: {
  imports = [
    ./iso.nix
    ../nix-config/nixos/vm.nix
  ];

  isoImage = {
    isoName = lib.mkForce "nixos-vm.iso";
  };
}
