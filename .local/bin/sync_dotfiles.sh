#!/usr/bin/env zsh


MOUNTPOINT=/mnt/usb

if [[ $1 != "backup" && $1 != "restore" ]]; then
    echo "Nothing specified. Use either backup/restore"
    exit 1
fi

# if [[ "$(id -u)" -eq 0 ]];then
#     echo "Cannot run script as root!"
#     exit 1
# fi

# notify if there is no usb attached
USB=$(lsblk | grep -oE "sd[ab][1-9]")
if [[ $USB == "" ]]; then
    echo "No usb attached"
    exit 1
fi


# Report the status for the mapping

if ! mountpoint $MOUNTPOINT; then
    sudo mount /dev/$USB $MOUNTPOINT && echo "Mounted successfully"
fi

if [[ $1 == "backup" ]]; then
    echo "---------------------------------------------------"
    echo "Synching $HOME/$dotfiles to $MOUNTPOINT/dotfiles"
    # Deletes extraneous files and forces deletetion of non-empy dirs
    # Specify root user as owner
    sudo rsync -avh --delete --force --perms --chown=root:root  $HOME/dotfiles $MOUNTPOINT
    echo "---------------------------------------------------"
elif [[ $1 == "restore" ]]; then
    echo "---------------------------------------------------"
    echo "Synching $MOUNTPOINT/dotfiles to $HOME/dotfiles"
    # Deletes extraneous files and forces deletetion of non-empy dirs
    sudo rsync -avh --delete --force --perms --chown=$USER:$USER  $MOUNTPOINT/dotfiles $HOME
    echo "---------------------------------------------------"
fi

if mountpoint /mnt/usb; then
    sudo umount /dev/sda1
fi
