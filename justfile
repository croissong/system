all: iso vm

iso:
  nixos-generate --format iso --configuration nix-bootstrap/iso.nix -o generated -I nixpkgs=channel:nixpkgs-unstable


iso-vm:
  nixos-generate --format iso --configuration nix-bootstrap/iso-vm.nix -o generated -I nixpkgs=channel:nixpkgs-unstable

vm:
  pkill qemu || echo 0
  # quickemu --vm vm/qemu.conf --delete-disk
  quickemu --vm vm/qemu.conf --public-dir .  --display gtk
