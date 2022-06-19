# https://github.com/nix-community/nixbox


variable "disk_size" {
  type = number
  default = 10240
}

variable "memory" {
  type = number
  default = 1024
}

packer {
  required_plugins {
    sshkey = {
      version = ">= 1.0.2"
      source = "github.com/ivoronin/sshkey"
    }
  }
}

data "sshkey" "install" {}

source "qemu" "nix" {
  boot_wait = "40s"
  iso_url = "file:file://../nix-iso-out/iso/nixos-22.11pre385916.103a4c0ae46-x86_64-linux.iso"
  iso_checksum = "none"
  shutdown_command = "sudo shutdown -h now"
  # shutdown_command = "echo hi"
  shutdown_timeout = "300h"

  format = "qcow2"

  ssh_username = "nixos"
  ssh_private_key_file      = data.sshkey.install.private_key_path
  ssh_clear_authorized_keys = true
  http_content = {
    "/public_key.pub" = data.sshkey.install.public_key
    }

  headless = false
  boot_key_interval = "25ms"

  disk_size = var.disk_size
  disk_interface = "virtio-scsi"
  qemuargs = [
        [
          "-m",
          "${var.memory}"
        ]
  ]


  boot_command = [
    "<enter>",
        "mkdir -m 0700 .ssh<enter>",
        "curl -s http://{{ .HTTPIP }}:{{ .HTTPPort}}/public_key.pub > .ssh/authorized_keys<enter>",
      ]

}

build {
  sources = ["sources.qemu.nix"]

  provisioner "shell" {
    script = "${path.root}/provision.sh"
  }

  post-processors {
    post-processor "vagrant" {
      output = "${path.root}/nix.box"
    }
  }
}