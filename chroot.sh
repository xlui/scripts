#!/bin/bash

Error () {
	echo "Error occured!"
	echo "${1}"
	exit 1
}

echo Configure language
cp /etc/locale.gen /tmp/locale.gen
cat /tmp/locale.gen | sed '/zh_CN\ GB2312/d' | sed '/zh_CN\.GBK\ GBK/d' | sed '/zh_CN\.UTF-8\ UTF-8/d' >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.GBK GBK" >> /etc/locale.gen
echo "zh_CN GB2312" >> /etc/locale.gen
locale-gen

echo Set time zone info
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc --local

echo Change hostname and root password
echo "ArchLinux" > /etc/hostname
echo root:rootpasswd | chpasswd

echo Add archlinuxcn repositories
pacman_conf="/etc/pacman.conf"
cat /etc/pacman.conf | grep archlinuxcn
if [ $? -ne 0  ]; then
	echo "[archlinuxcn]" >> $pacman_conf
	echo "SigLevel = Optional TrustAll" >> $pacman_conf
	echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> $pacman_conf
fi

# sync repositories
pacman -Syy
if [ $? -ne 0  ]; then
	Error "Error during sync the repositories, please run this script again to try to solve this error"
fi

echo Install base softwares and configure grub
pacman -S vim net-tools dnsutils git grub os-prober ntfs-3g dialog wpa_supplicant openssh --noconfirm
if [ $? -ne 0  ]; then
	Error "Error during install the base softwares, please run the script again to try to solve"
fi
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable dhcpcd
exit 0
