mounthost() {
    mkdir host
    mount host host -t 9p -o trans=virtio
}

playbook() {
    cd ./playbook
    ansible-playbook -i localhost install.yml --skip-tags 'role::btrfs:pkts' "$@"
}

case "$1" in
    mount) mounthost ;;
    playbook) playbook "${@:2}" ;;
    *)
        echo
        echo "Usage: $0 { mount | playbook }"
        echo
        exit 1 ;;
esac

exit 0
