mounthost() {
    mkdir host
    mount host host -t 9p -o trans=virtio
}

install() {
    cd ./playbook
    ansible-playbook -i localhost install.yml --skip-tags 'role::btrfs:pkts' "$@"
}

configure() {
    cd ./playbook
    ansible-playbook --ask-become-pass -i localhost configure.yml "$@"
}

case "$1" in
    mount) mounthost ;;
    install) install "${@:2}" ;;
    configure) configure "${@:2}" ;;
    *)
        echo
        echo "Usage: $0 { configure | install | mount }"
        echo
        exit 1 ;;
esac

exit 0
