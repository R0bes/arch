#!/bin/bash

echo ""
echo ""
echo "Setup Arch Linux"

echo "Set Keys to german"
loadkeys de-latin1


# Disk Partitioning for encrypted system (seperate kernel partition 2)

echo "partition disk sda"
parted /dev/sda --script \
  mklabel gpt \
  mkpart "EFI" fat32 1MiB 301MiB \
  set 1 esp on \
  mkpart "Arch-Boot" ext4 301MiB  601MiB \
  mkpart "Arch-Crypt" ext4 602 MiB 100%



##partition
#fdisk -l
#
##anzeigen
#lsbulk
#
##graphisch
#cfdisk 
#
#mkfs.msdos -F 32 /dev/sdaX # uefi
#mkfs.ext4 /dev/sdaX # linux
#
##verschlüsseln 
#cryptsetup -v -y -cipher aes-xts-plain64 --key-size 256 --hash sha256 --ter-time 2000 --use-urandom --verify-passphrase luksFormat /dev/sdaX
#
## schatulle öffnen
#cryptsetup open /dev/mapper/NAME
#
##mount 
#mount /dev/mapper/NAME /mnt
#mount /dev/sda1 /mnt/boot/efi
#mount /dev/sda2 /mnt/boot
#
##packen
#pacstrap -i /mnt base base-devel linux linux-firmware nano
#
##file system table schreiben
#genfstab -U /mnt >> /mnt/etc/fstab
#
## ab ins system
#arch-chroot /mnt
#
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
#
## exit
#exit
#
## unmount
#umount -R /mnt
#
## schatulle schließen
#cryptsetup close NAME
