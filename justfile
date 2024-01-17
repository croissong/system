all: iso vm

_iso entrypoint:
  ouch compress -g -y \
    . \
    ~/Dot \
    ~/.config/age/identity.age \
    iso-contents.tar.sz
  nixos-generate --format iso --configuration nix-bootstrap/{{entrypoint}} -o generated -I nixpkgs=channel:nixpkgs-unstable

iso: (_iso "iso.nix")

iso-vm: (_iso "iso-vm.nix")

vm delete="false":
  pkill qemu || echo 0
  {{ if delete == "delete" { "quickemu --vm vm/qemu.conf --delete-disk" } else { ""} }}
  quickemu --vm vm/qemu.conf
