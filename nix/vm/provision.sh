#!/usr/bin/env bash

cd /iso/ansible
{
  ansible-galaxy install --no-deps -r requirements.yml
  ansible-playbook playbook.yml

  sudo nixos-generate-config --root /mnt
  sudo mv /mnt/etc/nixos/configuration.nix /mnt/etc/nixos/configuration.generated.nix
  sudo cp ../config/configuration.nix /mnt/etc/nixos/configuration.nix
  sudo nixos-install
} || {
  exit 0
}
