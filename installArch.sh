#!/bin/bash

Continue ()
{
    sleep 2
    read -p "sure ?" queren
    if [ ${queren:0:1} = 'n'  ]; then
        exit 1
    fi
}

echo "please make sure you have parted and mounted already!!!"
mount | grep sda
if [ $? -ne 0  ]; then
	echo "please mount before!!!"
	exit 0
fi

echo "add ArchLinuxcn source to pacman's conf, and change /etc/pacman.d/mirrorlist"
# pacman.conf
cat /etc/pacman.conf | grep archlinuxcn
if [ $? -ne 0  ]; then
	pacman_conf="/etc/pacman.conf"
	pacman_mirrorlist="/etc/pacman.d/mirrorlist"
	# pacman.conf
	echo "[archlinuxcn]" >> $pacman_conf
	echo "SigLevel = Optional TrustAll" >> $pacman_conf
	echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> $pacman_conf
fi
# mirrorlist
echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' > $pacman_mirrorlist


echo update source and install base system
echo please make sure you have a good network!!!
pacman -Syy
pacstrap /mnt base base-devel

if [ $? -ne 0  ]; then
	echo Error occured during install base system! please run script again
	exit 1
fi


echo generate fstab and chroot
genfstab -U -p /mnt >> /mnt/etc/fstab
wget https://raw.githubusercontent.com/nxmup/AutoInstall/master/chroot.sh
cp chroot.sh /mnt
chmod +x /mnt/chroot.sh
arch-chroot /mnt /bin/bash -c "./chroot.sh"


echo "Root password is: rootpasswd, please use command: passwd root  change your password immediately!!!!"
echo "Default language is en_US, please change it from /etc/locale.conf if u want."
echo "Default timezone is Asia/Shanghai, change it if u want."
