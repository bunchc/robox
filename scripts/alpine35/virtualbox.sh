#!/bin/bash

error() {
        if [ $? -ne 0 ]; then
                printf "\n\nvbox install failed...\n\n";
                exit 1
        fi
}

# Bail if we are not running inside VirtualBox.
if [[ `dmidecode -s system-product-name` != "VirtualBox" ]]; then
    exit 0
fi

# Install the Virtual Box Tools from the Linux Guest Additions ISO.
printf "Installing the Virtual Box Tools.\n"

# Read in the version number.
export VBOXVERSION=`cat /root/VBoxVersion.txt`
#
# export DEBIAN_FRONTEND=noninteractive
# apt-get --assume-yes install dkms build-essential module-assistant linux-headers-$(uname -r); error
#
# mkdir -p /mnt/virtualbox; error
# mount -o loop /root/VBoxGuestAdditions.iso /mnt/virtualbox; error
#
# /mnt/virtualbox/VBoxLinuxAdditions.run --nox11; error
# ln -s /opt/VBoxGuestAdditions-$VBOXVERSION/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions; error
#
# umount /mnt/virtualbox; error
rm -rf /root/VBoxVersion.txt; error
rm -rf /root/VBoxGuestAdditions.iso; error

# Boosts the available entropy which allows magma to start faster.
apk add --force haveged; error

# Autostart the haveged daemon.
rc-update add haveged default && rc-service haveged start
