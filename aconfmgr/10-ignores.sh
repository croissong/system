IgnorePath '/var/lib/docker/*'

IgnorePath '/var/lib/pacman/local/*' # package metadata
IgnorePath '/var/lib/pacman/sync/*.db' # repos
IgnorePath '/var/lib/pacman/sync/*.db.sig' # repo sigs


# https://github.com/CyberShadow/aconfmgr/issues/37

# Boot binaries
IgnorePath '/boot/*.img'
IgnorePath '/boot/*/*.EFI'
IgnorePath '/boot/*/*.efi'
IgnorePath '/boot/vmlin*'
IgnorePath '/boot/EFI/*'

# Certificate databases
IgnorePath '/etc/ca-certificates/extracted/*'
IgnorePath '/etc/ssl/certs/*'
IgnorePath '/etc/pacman.d/gnupg/*'
# Cache and generated files
IgnorePath '/etc/*.cache'
IgnorePath '/etc/*.gen'
# Password files
IgnorePath '/etc/*shadow*'
IgnorePath '/usr/share/*'
# Configuration database
IgnorePath '/etc/dconf'
# Mount files
IgnorePath '*/.updated'
IgnorePath '*/lost+found/*'
# Opt packages (check that they don't include config)
IgnorePath '/opt/*'
# Binary libraries
IgnorePath '/usr/lib/*'
# Local binaries
IgnorePath '/usr/local/include/*'
IgnorePath '/usr/local/lib/*'
IgnorePath '/usr/local/share/applications/mimeinfo.cache'
# Var databases, logs, swap and temp files
IgnorePath '/var/db/sudo'
IgnorePath '/var/lib/*'
IgnorePath '/var/log/*'
IgnorePath '/var/swap*'
IgnorePath '/var/tmp/*'


# Ignore probably forever
IgnorePath '/etc/.pwd.lock'
IgnorePath '/etc/adjtime'
IgnorePath '/etc/brlapi.key'
IgnorePath '/etc/dbeaver/*'
IgnorePath '/etc/docker/key.json'
IgnorePath '/etc/texmf/*'
IgnorePath '/usr/local/bin/*'
IgnorePath '/usr/bin/*'
IgnorePath '/usr/man/*'
IgnorePath '/var/spool/*'
IgnorePath '/.snapshots/*'
IgnorePath '/etc/docker/key.json'
IgnorePath '/etc/redis/*'

IgnorePath '/home/croissong*'


# Ignore for now
IgnorePath '/boot/loader'
IgnorePath '/etc/conf.d/*'
IgnorePath '/etc/ca-certificates'

IgnorePath '/etc/swanctl/*'
IgnorePath '/etc/sudoers'
IgnorePath '/usr/local/share/*'



IgnorePath "/etc/"{cups,fonts,geoclue,wireguard,iwd,keybase,libvirt,light,mkinitcpio.d,modprobe.d,pam.d,ppp,reflector,sgml,udev,xdg/reflector,xl2tpd,xml,docker,keybase}"/*"
IgnorePath "/etc/"{fstab,group,hostname,hosts,ipsec,locale.conf,machine-id,nftables.conf,odbcinst.ini,os-release,passwd,printcap,shells,strongswan,subgid,subuid,vconsole.conf}"*"
