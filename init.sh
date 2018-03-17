

# mkdir /opt/host
# mount host /opt/host -t 9p -o trans=virtio

cd /opt/host

# sed -n '5p' init.sh


cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

pacman -Sy --noconfirm  ansible python2-passlib
ansible-galaxy install debops-contrib.btrfs

ansible-playbook -i localhost install.yml
