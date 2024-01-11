#!/usr/bin/env bash
set -euxo pipefail

disk=$1

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

# validate
# NIXOS_CONFIG="$PWD"/config/configuration.nix nix-instantiate '<nixpkgs/nixos>' -A sys

nix run github:nix-community/disko -- --mode disko ./disk-config.nix --arg disks "[ \"/dev/$disk\" ]"

nixos-generate-config --no-filesystems --root /mnt
mv /mnt/etc/nixos/configuration.nix /mnt/etc/nixos/configuration.generated.nix
cp -r config/* /mnt/etc/nixos/
nixos-install --no-root-passwd --verbose | tee /tmp/nixos-install.log
