#!/usr/bin/env bash
set -euxo pipefail

disk=""
hostname="bon"

if [[ $1 =~ "vm" ]]; then
  disk="sda"
  hostname="bonVM"
fi

cd /iso/system

# validate
# NIXOS_CONFIG="$PWD"/config/configuration.nix nix-instantiate '<nixpkgs/nixos>' -A sys

SOPS_AGE_KEY_FILE=/iso/age-keys.txt sops -d --extract '["luks"]' nix-config/secrets.yaml >/tmp/luks-password.txt

nix run github:nix-community/disko -- --mode disko nix/disk-config.nix --arg disks "[ \"/dev/$disk\" ]"

mkdir /mnt/etc
cp -r /iso/system /mnt/etc/system/
cd /mnt/etc/system/nix-config
nixos-generate-config --no-filesystems --root /mnt --dir nixos/
nixos-install --no-root-passwd --verbose --flake path://$PWD#$hostname | tee /tmp/nixos-install.log
