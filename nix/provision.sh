#!/usr/bin/env bash
set -euxo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
# validate
NIXOS_CONFIG="$SCRIPT_DIR"/config/configuration.nix nix-instantiate '<nixpkgs/nixos>' -A system

pushd "$SCRIPT_DIR"/ansible || exit
ansible-galaxy install --no-deps -r requirements.yml
ansible-playbook playbook.yml | tee /tmp/ansible-playbook.log

popd || exit
# sudo nixos-generate-config --root /mnt
# sudo mv /mnt/etc/nixos/configuration.nix /mnt/etc/nixos/configuration.generated.nix
sudo mkdir -p /mnt/etc/nixos/
sudo cp -r "$SCRIPT_DIR"/config/* /mnt/etc/nixos/
sudo nixos-install --no-root-passwd --verbose | tee /tmp/nixos-install.log
