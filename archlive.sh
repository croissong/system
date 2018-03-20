if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@" 
fi

rm -r archlive && mkdir archlive

cp /usr/share/archiso/configs/releng/* archlive/
cp -r playbook archlive/airootfs/root/
cd archlive
cat >packages.x86_64 <<EOL
ansible
python2-passlib
EOL
mkdir -p airootfs/etc/pacman.d/ && cp /etc/pacman.d/mirrorlist airootfs/etc/pacman.d/
cat >>airootfs/root/customize_airootfs.sh <<EOL
loadkeys de-latin1
mount host /opt/host -t 9p -o trans=virtio
EOL
./build.sh -v

