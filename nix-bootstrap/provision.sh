#!/usr/bin/env bash
set -euxo pipefail

disk="vda"
hostname="bon"

if [[ $BON_VM =~ "true" ]]; then
  disk="vda"
  hostname="bonVM"
fi

ouch decompress -y /iso/iso-contents.tar.sz --dir /tmp
cd /tmp/iso-contents/System

SOPS_AGE_KEY_FILE=/tmp/iso-contents/identity.age sops -d --extract '["luks"]' nix-config/secrets.yaml >/tmp/luks-password.txt
nix run github:nix-community/disko -- --mode disko nix-bootstrap/disk-config.nix --arg disks "[ \"/dev/$disk\" ]"

mkdir /mnt/etc/
cp -r /tmp/iso-contents/identity.age /mnt/etc/identity.age

nixos-generate-config --no-filesystems --root /mnt --dir /tmp/iso-contents/System/nix-config/nixos/

nixos-install --no-root-passwd --verbose --flake path:///tmp/iso-contents/System/nix-config#$hostname | tee /tmp/nixos-install.log

cp -r /tmp/iso-contents/Dot /mnt/home/moi/Dot
cp -r /tmp/iso-contents/System /mnt/home/moi/System
chown -R moi /mnt/home/moi/System
chown -R moi /mnt/home/moi/Dot
