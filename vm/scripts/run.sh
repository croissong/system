#!/usr/bin/env bash
set -exo pipefail

# chown -R moi /home/moi/System
# chown -R moi /home/moi/Dot

home-manager switch --flake path://$HOME/System/nix-config#moi@bon

sudo nixos-rebuild switch --flake path://$HOME/System/nix-config#bonVM
