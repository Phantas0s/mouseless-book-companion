#!/bin/bash

# Never run pacman -Sy on your real system!
pacman -Sy dialog --noconfirm

timedatectl set-ntp true

# Welcome message of type yesno - see `man dialog`
dialog --defaultno --title "Are you sure?" --yesno "This is my personnal
arch linux install. \n\n\
It will just DESTROY EVERYTHING on the hard disk of your choice. \n\n\
Don't say YES if you are not sure about what you're doing! \n\n\
Are you sure?" 15 60 || exit

dialog --no-cancel --inputbox "Enter a name for your computer." \
10 60 2> comp

# Verify boot (UEFI or BIOS)
uefi=0
ls /sys/firmware/efi/efivars 2> /dev/null && uefi=1

# Choosing the hard drive
devices_list=($(lsblk -d | awk '{print "/dev/" $1 " " $4 " on"}' \
    | grep -E 'sd|hd|vd|nvme|mmcblk'))

dialog --title "Choose your hard drive" --no-cancel --radiolist \
"Where do you want to install your new system?\n\n\
Select with SPACE, valid with ENTER.\n\n\
WARNING: Everything will be DESTROYED on the hard disk!" \
15 60 4 "${devices_list[@]}" 2> hd

hd=$(cat hd) && rm hd


