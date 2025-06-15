#!/usr/bin/env zsh


# Automatically asks for the password for the luks partition
# on a disk, mounts it and pushes new commits from the pass repo

MOUNTPOINT=/mnt/usb
TEMP_FILESYSTEM=backup_passwords

error() {
    echo "error: $1"
    exit 1
}

if [[ "$(id -u)" -eq 0 ]];then
    echo "Cannot run script as root!"
    exit 1
# notify if there is no usb attached and exit
elif [[ ! $(lsblk | grep -E "sd[ab]") ]]; then
    error "no usb attached!"
fi



lsblk -f
volume_to_open=$(gum input --placeholder 'sda' --no-show-help)


gum confirm "use '$volume_to_open'?" || error "you aborted!"
# Abort if user entered root volume_to_open
lsblk | grep $volume_to_open | grep "part /" && error "This is the root partition!"

# Open the luks partition. This may ask for the user password.
# This will fail if the usb is discovered later, (e.g. if the main disk is sda?)
sudo cryptsetup open --type luks /dev/$volume_to_open $TEMP_FILESYSTEM || error "Could not open volume!"
sudo mount  /dev/mapper/$TEMP_FILESYSTEM $MOUNTPOINT || error "Could not mount"

cd ~/.password-store
sudo git push usbdrive main || echo "Failed to push."

# Umount the disk
sudo umount /dev/mapper/$TEMP_FILESYSTEM || error "Failed to umount. Manual intervention required"
sudo cryptsetup close $TEMP_FILESYSTEM || error "Failed to close the volume. Manual intervention required".

echo "Finished backup of passwords sucessfully"
