#!/bin/bash

echo ""
echo ""
echo "Setup Arch Linux"

echo "Set Keys to german ....."
loadkeys de-latin1


# Disk Partitioning for encrypted system (seperate kernel partition 2)

echo "partition disk sda ....."
parted -s /dev/sda -- mklabel gpt \
  mkpart "EFI" fat32 1MiB 301MiB set 1 esp on \
  mkpart "Arch-Boot" ext4 301MiB  601MiB \
  mkpart "Arch-Crypt" ext4 601MiB 100%

echo "create file systems for efi and boot ....."
mkfs.msdos -F 32 /dev/sda1
mkfs.ext4 /dev/sda2


# encrypt
#echo "going to setup encrypted disk sda3, enter passphrase:"
#cryptsetup -v -y -cipher aes-xts-plain64 --key-size 256 --hash sha256 --ter-time 200 --use-urandom --verify-passphrase luksFormat /dev/sda3

#decryptedDisk=ArchData

# schatulle öffnen
#echo "open disk ...."
#cryptsetup open /dev/mapper/$decryptedDisk

#mount 
#echo "mount partitions ...."
#mount /dev/mapper/$decryptedDisk /mnt
#mount /dev/sda1 /mnt/boot/efi
#mount /dev/sda2 /mnt/boot


#packen
#echo "pacstrap ...."
#pacstrap -i /mnt base base-devel linux linux-firmware nano

#file system table schreiben
#echo "genfstab ...."
#genfstab -U /mnt >> /mnt/etc/fstab

# ab ins system
#echo "login arch"
#arch-chroot /mnt


#pacman -S efibootmgr dosfstools gptfdisk --noconfirm
#
##wifi
#pacman -S wpa_supplicant dialog
#
##grub
#pacman -S grub
#pacman -S dhcpcd
#
##time
#ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
#hwclock --systohc
#
##encoding
#uncommecnt de_DE.UTF-8 UTF-8 in /etc/locale.gen
#LANG=de_DE.UTF-8 in /etc/locale.conf
#
## pc name
#echo NAME >> /etc/hostname
#
#
## encrypt hook
#/etc/mkinitcpio.conf add encrypt in HOOKS list before (!) filesystem
## gen image
#mkinitcpio -P
#
##root pass
#passwd
#
#
##grub installieren
#grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=xxxx --recheck
#
#
## encrypt 
#change GRUB_CMDLINE_LINUX to "cryptdevice=/dev/sda3:NAME root=/dev/mapper/NAME"
#
##make grub config
#grub-mkconfig -o /boot/grub/grub.cfg
#
##enable network
#systemctl enable dhcpcd

## exit
#echo "exit arch"
#exit

# unmount
#echo "unmount ...."
#umount -R /mnt

echo "close disk ....."
# schatulle schließen
#cryptsetup close $decryptedDisk
