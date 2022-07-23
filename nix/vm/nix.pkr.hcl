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
  iso_url = "file:file://../nix-iso-out/iso/nixos.iso"
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

  headless = true
  boot_key_interval = "50ms"
  vnc_port_min = 5962
  vnc_port_max = 5962

  firmware = "/usr/share/edk2-ovmf/x64/OVMF.fd"
  use_pflash = true

  accelerator = "kvm"

  disk_size = var.disk_size
  disk_interface = "virtio-scsi"
  qemuargs = [
    ["-m", "${var.memory}"]
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
    inline = ["/iso/provision.sh"]
  }

  post-processors {
    post-processor "vagrant" {
      output = "${path.root}/nix.box"
      vagrantfile_template = "${path.root}/Vagrantfile"
    }
  }
}
