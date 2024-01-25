#!/usr/bin/env bash
set -euxo pipefail

disk="nvme0n1"
hostname="bon"

if [[ $BON_VM =~ "true" ]]; then
  disk="vda"
  hostname="bonVM"
fi

ouch decompress -y /iso/iso-contents.tar.sz --dir /tmp
cd /tmp/iso-contents/System

SOPS_AGE_KEY_FILE=/tmp/iso-contents/identity.age sops -d --extract '["luks"]' nix-config/secrets.yaml >/tmp/luks-password.txt
nix run github:nix-community/disko -- --mode disko bootstrap/disk-config.nix --arg disks "[ \"/dev/$disk\" ]"

# TODO: no need to cp before?
mkdir -p /mnt/tmp/home/dot
mkdir -p /mnt/tmp/home/.config/age
cp -r /tmp/iso-contents/System /mnt/tmp/home/dot/system
cp -r /tmp/iso-contents/Dot /mnt/tmp/home/dot/dotfiles
cp -r /tmp/iso-contents/Dot/priv /mnt/tmp/home/dot/priv
cp /tmp/iso-contents/identity.age /mnt/tmp/home/.config/age/identity.age
mkdir -p /mnt/etc/age/
cp /tmp/iso-contents/identity.age /mnt/etc/age/identity.age

nixos-generate-config --no-filesystems --root /mnt --dir /tmp/iso-contents/System/nix-config/nixos/

nixos-install --no-root-passwd --impure --verbose \
  --flake path:///tmp/iso-contents/System/nix-config#$hostname 2>&1 |
  tee /tmp/nixos-install.log

cp -r /mnt/tmp/home/dot /mnt/home/moi/dot
cp /tmp/iso-contents/System/nix-config/nixos/hardware-configuration.nix /mnt/home/moi/dot/system/nix-config/nixos/hardware-configuration.nix

mkdir -p /mnt/home/moi/.config
cp -r /mnt/tmp/home/.config/age /mnt/home/moi/.config/age
cp /tmp/iso-contents/private.pgp /mnt/home/moi/private.pgp

nixos-enter -c 'chown -R moi:users /home/moi'
