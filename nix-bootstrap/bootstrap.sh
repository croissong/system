#!/usr/bin/env bash
sleep 3

mkdir ~/shared
sudo mount -t 9p -o trans=virtio,version=9p2000.L,msize=104857600 Public-croissong ~/shared
cd ~/shared

/iso/nix-bootstrap/provision.sh
