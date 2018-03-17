# trizen -S ovmf
# https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF#Setting_up_an_OVMF-based_guest_VM
# systemctl start libvirtd virtlogd.service dnsmasq.service ebtables.service



http://troglobit.github.io/2013/07/05/file-system-pass-through-in-kvm-slash-qemu-slash-libvirt/

<filesystem type='mount' accessmode='mapped'>
    <source dir='/tmp/shared'/>
    <target dir='tag'/>
</filesystem>

mount -t 9p -o trans=virtio,version=9p2000.L tag /mnt/shared/