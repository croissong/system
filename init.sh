

# mkdir /opt/host
# mount host /opt/host -t 9p -o trans=virtio

cd /opt/host

# sed -n '5p' init.sh


# awk '/^### Germany$/ {f=1} f==0 {next} /^$/ {exit} {print "#" $0}' /etc/ pacman.d/mirrorlist	       

pacman -Sy --noconfirm ansible python2-passlib

ansible-playbook -i localhost install.yml --skip-tags 'role::btrfs:pkts'
