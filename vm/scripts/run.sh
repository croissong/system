#!/usr/bin/env bash
set -exo pipefail

# journalctl -f -u provision

cp -r /iso/nix-config /mnt/etc/nix-config
cp /iso/age-keys.txt /mnt/etc/age-keys.txt

nixos-generate-config --no-filesystems --root /mnt --dir /mnt/nix-config/nixos/
nixos-install --no-root-passwd --verbose --flake path://$PWD/nix-config#bonVM
