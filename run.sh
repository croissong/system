mount() {
    mkdir ./host
    mount host ./host -t 9p -o trans=virtio
}

playbook() {
    cd ./playbook
    ansible-playbook -i localhost install.yml --skip-tags 'role::btrfs:pkts' "$@"
}

case "$1" in
    'mount') mount ;;
    'playbook') playbook "${@:2}" ;;
    'reset') ;;
    *)
        echo
        echo "Usage: $0 { start | stop | restart | status }"
        echo
        exit 1 ;;
esac

exit 0
