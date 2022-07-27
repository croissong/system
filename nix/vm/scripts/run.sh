#!/usr/bin/env bash
cp -r /mnt/nix/config/* /etc/nixos/
nixos-rebuild switch
