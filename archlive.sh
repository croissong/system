if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@" 
fi

rm -rf archlive && mkdir archlive

cp -r /usr/share/archiso/configs/releng/* archlive/
cp -r playbook archlive/airootfs/root/playbook
cp run.sh archlive/airootfs/root/run.sh
cd archlive
cat >packages.x86_64 <<EOL
ansible
python2-passlib
EOL
cp /etc/vconsole.conf airootfs/etc/
mkdir airootfs/etc/pacman.d && cp /etc/pacman.d/mirrorlist airootfs/etc/pacman.d/
cat >>airootfs/root/customize_airootfs.sh <<EOL
EOL
./build.sh -V '' -v

