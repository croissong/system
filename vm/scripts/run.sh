#!/usr/bin/env bash
set -exo pipefail

# chown -R moi /home/moi/System
# chown -R moi /home/moi/Dot

home-manager switch --flake ~/System/nix-config#moi@bon

sudo nixos-rebuid-switch --flake ~/System/nix-config#bonVM
