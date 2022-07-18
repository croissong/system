#!/usr/bin/env bash

cd /iso/ansible || exit
{
  ansible-galaxy install --no-deps -r requirements.yml
  ansible-playbook playbook.yml

  # sudo nixos-generate-config --root /mnt
  # sudo mv /mnt/etc/nixos/configuration.nix /mnt/etc/nixos/configuration.generated.nix
  sudo mkdir -p /mnt/etc/nixos/
  sudo cp -r ../config/* /mnt/etc/nixos/
  sudo nixos-install --no-root-passwd --verbose
} || {
  exit 0
}
