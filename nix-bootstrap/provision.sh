#!/usr/bin/env bash
set -euxo pipefail

disk="vda"
hostname="bon"

echo $BON_VM >/tmp/bon-vm.txt

if [[ $BON_VM =~ "true" ]]; then
  disk="vda"
  hostname="bonVM"
fi

# validate
# NIXOS_CONFIG="$PWD"/config/configuration.nix nix-instantiate '<nixpkgs/nixos>' -A sys

cd /iso/nix-config

mkdir /mnt/etc
cp -r /iso/nix-config /mnt/etc/nix-config
cp /iso/age-keys.txt /mnt/etc/age-keys.txt

SOPS_AGE_KEY_FILE=/mnt/age-keys.txt sops -d --extract '["luks"]' /mnt/etc/nix-config/secrets.yaml >/tmp/luks-password.txt

nix run github:nix-community/disko -- --mode disko /mnt/etc/nix-bootstrap/disk-config.nix --arg disks "[ \"/dev/$disk\" ]"

nixos-generate-config --no-filesystems --root /mnt --dir /mnt/etc/nix-config/nixos/

nixos-install --no-root-passwd --verbose --flake path:///mnt/nix-config#$hostname | tee /tmp/nixos-install.log
