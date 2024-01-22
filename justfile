all: iso vm

_iso entrypoint:
  gpg --output /tmp/private.pgp --armor --export-secret-key jan.moeller0@gmail.com
  ouch compress -g -y \
    . \
    ~/Dot \
    ~/.config/age/identity.age \
    /tmp/private.pgp \
    iso-contents.tar.sz

  nixos-generate --format iso --configuration bootstrap/{{entrypoint}} -o generated -I nixpkgs=channel:nixpkgs-unstable

iso: (_iso "iso.nix")

iso-vm: (_iso "iso-vm.nix")

usb:
  sudo ventoy -g -I /dev/sdb

vm delete="false":
  pkill qemu || echo 0
  {{ if delete == "delete" { "quickemu --vm vm/qemu.conf --delete-disk" } else { ""} }}
  quickemu --vm vm/qemu.conf
