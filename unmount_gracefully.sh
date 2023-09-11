#!/bin/bash

# Check if the script is run as root to have permission to unmount.
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root."
    exit 1
fi

# Specify the mount point of the disk you want to unmount.
mount_point="/mnt/mydisk"

# Check if the specified mount point exists.
if [ ! -d "$mount_point" ]; then
    echo "Mount point does not exist: $mount_point"
    exit 1
fi

# Check if the mount point is currently in use (has open files).
if lsof +D "$mount_point" >/dev/null 2>&1; then
    echo "Unmount failed: Mount point is in use."
    exit 1
fi

# Attempt to unmount the disk gracefully.
umount "$mount_point"

# Check the exit status of the umount command.
if [ $? -eq 0 ]; then
    echo "Unmounted successfully: $mount_point"
else
    echo "Unmount failed: $mount_point"
fi
