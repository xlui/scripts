#!/bin/bash
echo configure language
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.GBK GBK" >> /etc/locale.gen
echo "zh_CN GB2312" >> /etc/locale.gen
locale-gen

echo set time zone info
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc --local

echo change hostname and root password
echo "ArchLinux" > /etc/hostname
echo root:rootpasswd | chpasswd

echo Install base softwares and configure grub
pacman -S vim net-tools dnsutils git grub os-prober ntfs-3g dialog wpa_supplicant --noconfirm
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable dhcpcd
exit
