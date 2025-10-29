#!/usr/bin/env bash
set -euf

USERNAME=$(whoami)
TKENV_MOUNTPOINT="/home/$USERNAME/tkenv"

open () {
    sudo cryptsetup open tkenv.luks tkenv
    sudo mount /dev/mapper/tkenv "$TKENV_MOUNTPOINT"
    echo "tkenv successfully mounted at $TKENV_MOUNTPOINT"
}

close () {
    set +e
    sudo umount /dev/mapper/tkenv
    sudo cryptsetup close tkenv
    set -e
}

setup () {
    set -x
    if [ ! -d "$TKENV_MOUNTPOINT" ]; then
        mkdir -p "$TKENV_MOUNTPOINT"
    fi
    if [ ! -f "tkenv.luks" ]; then
        set +x
        echo "Creating tkenv.luks..."
        set -x
        sudo truncate -s "$1"G tkenv.luks
        sudo cryptsetup luksFormat tkenv.luks
    else
        set +x
        echo "tkenv.luks already exists."
        set -x
    fi
    sudo cryptsetup open tkenv.luks tkenv
    sudo mkfs.ext4 /dev/mapper/tkenv
    sudo mount /dev/mapper/tkenv "$TKENV_MOUNTPOINT"
    sudo chown "$USERNAME":"$USERNAME" tkenv.luks
    sudo chown "$USERNAME":"$USERNAME" "$TKENV_MOUNTPOINT"
    sudo rm -rf "$TKENV_MOUNTPOINT"/lost+found
    close
    set +x
    echo "tkenv setup complete."
}

case "$1" in
    setup)
        if [ $# -lt 2 ]; then
            echo "Usage: $0 setup <size_in_GB>"
            exit 1
        fi
        setup "$2"
        ;;
    open)
        open
        ;;
    close)
        close
        ;;
    *)
        echo "Usage: $0 {setup <size>|open|close}"
        exit 1
        ;;
esac