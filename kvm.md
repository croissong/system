# trizen -S ovmf
# https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF#Setting_up_an_OVMF-based_guest_VM
# systemctl start libvirtd virtlogd.service dnsmasq.service ebtables.service


sudo qemu-img create -f qcow2 /var/lib/libvirt/images/arch.qcow2 20G && sudo virsh define vm.xml

mount -t 9p -o trans=virtio,version=9p2000.L tag /mnt/shared/

# ansible submodule symlink not working