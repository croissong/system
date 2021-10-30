CopyFile /etc/pacman.conf
CopyFile /etc/pacman.d/hooks/clean-cache.hook
CopyFile /etc/pacman.d/hooks/pacdiff.hook 600

CreateLink /etc/localtime /usr/share/zoneinfo/Europe/Berlin

CreateLink /etc/resolv.conf /run/systemd/resolve/stub-resolv.conf

CopyFile /etc/snapper/configs/config 640



CopyFile /etc/systemd/logind.conf
CopyFile /etc/systemd/network/10-wlan0.link
CopyFile /etc/systemd/network/11-eth0.link
CopyFile /etc/systemd/network/20-bond.netdev
CopyFile /etc/systemd/network/20-bond.network
CopyFile /etc/systemd/network/25-wired.network
CopyFile /etc/systemd/network/30-wireless.network
CopyFile /etc/systemd/resolved.conf




CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/dbus-org.bluez.service /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.network1.service /usr/lib/systemd/system/systemd-networkd.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.resolve1.service /usr/lib/systemd/system/systemd-resolved.service

CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/multi-user.target.wants/earlyoom.service /usr/lib/systemd/system/earlyoom.service
CreateLink /etc/systemd/system/multi-user.target.wants/iwd.service /usr/lib/systemd/system/iwd.service
CreateLink /etc/systemd/system/multi-user.target.wants/lm_sensors.service /usr/lib/systemd/system/lm_sensors.service
CreateLink /etc/systemd/system/multi-user.target.wants/nftables.service /usr/lib/systemd/system/nftables.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target
CreateLink /etc/systemd/system/multi-user.target.wants/systemd-networkd.service /usr/lib/systemd/system/systemd-networkd.service
CreateLink /etc/systemd/system/multi-user.target.wants/systemd-resolved.service /usr/lib/systemd/system/systemd-resolved.service

CreateLink /etc/systemd/system/multi-user.target.wants/tlp.service /usr/lib/systemd/system/tlp.service
CreateLink /etc/systemd/system/sleep.target.wants/tlp-sleep.service /usr/lib/systemd/system/tlp-sleep.service

CreateLink /etc/systemd/system/sockets.target.wants/cups.socket /usr/lib/systemd/system/cups.socket
CreateLink /etc/systemd/system/sockets.target.wants/org.cups.cupsd.socket /usr/lib/systemd/system/org.cups.cupsd.socket

CreateLink /etc/systemd/system/sockets.target.wants/systemd-networkd.socket /usr/lib/systemd/system/systemd-networkd.socket
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service


CreateLink /etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service /usr/lib/systemd/system/systemd-networkd-wait-online.service


CopyFile /etc/systemd/system/physlock.service
CreateLink /etc/systemd/system/sleep.target.wants/physlock.service /etc/systemd/system/physlock.service

CopyFile /etc/systemd/system/reflector.timer
CreateLink /etc/systemd/system/timers.target.wants/reflector.timer /etc/systemd/system/reflector.timer

CreateLink /etc/systemd/user/pipewire.service.wants/pipewire-media-session.service /usr/lib/systemd/user/pipewire-media-session.service
CreateLink /etc/systemd/user/sockets.target.wants/pipewire-pulse.socket /usr/lib/systemd/user/pipewire-pulse.socket
CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket

CreateLink /etc/systemd/user/sockets.target.wants/p11-kit-server.socket /usr/lib/systemd/user/p11-kit-server.socket

CreateLink /etc/containers/certs.d/smarthub-wbench.workbench.telekom.de/user.cert /home/croissong/.ssh/svh/user.crt
CreateLink /etc/containers/certs.d/smarthub-wbench.workbench.telekom.de/user.key /home/croissong/.ssh/svh/userkey.pem
CreateLink /etc/docker/certs.d /home/croissong/.config/containers/certs.d
# shrug
RemoveFile /etc/docker/certs.d
RemoveFile /etc/docker

CreateLink /etc/systemd/user/sockets.target.wants/dirmngr.socket /usr/lib/systemd/user/dirmngr.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-browser.socket /usr/lib/systemd/user/gpg-agent-browser.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-extra.socket /usr/lib/systemd/user/gpg-agent-extra.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-ssh.socket /usr/lib/systemd/user/gpg-agent-ssh.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent.socket /usr/lib/systemd/user/gpg-agent.socket


# mask rfkill, see https://wiki.archlinux.org/title/TLPö
CreateLink /etc/systemd/system/systemd-rfkill.service /dev/null
CreateLink /etc/systemd/system/systemd-rfkill.socket /dev/null
