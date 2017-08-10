#!/bin/bash

Continue ()
{
    read -p "sure ?" queren
    if [ ${queren:0:1} = 'n'  ]; then
        exit 1
    fi
}

Error () {
	echo "Error occured!"
	echo "${1}"
	exit 1
}

echo "Please make sure you have parted and mounted already!!!"
mount | grep sda
if [ $? -ne 0  ]; then
	Error "Please mount before run this script"
fi

pacman_conf="/etc/pacman.conf"
pacman_mirrorlist="/etc/pacman.d/mirrorlist"
echo "Add ArchLinuxcn source to pacman's conf, and change /etc/pacman.d/mirrorlist"
# pacman.conf
cat /etc/pacman.conf | grep archlinuxcn
if [ $? -ne 0  ]; then
	echo "[archlinuxcn]" >> $pacman_conf
	echo "SigLevel = Optional TrustAll" >> $pacman_conf
	echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> $pacman_conf
fi
# mirrorlist
echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' > $pacman_mirrorlist


echo Update source and install base system
echo Please make sure you have a good network!!!
Continue 
pacman -Syy
pacstrap /mnt base base-devel
if [ $? -ne 0  ]; then
	Error "Error occured during install the base system, please run the script again to try to deal with this error"
fi


echo Generate fstab and chroot
genfstab -U -p /mnt >> /mnt/etc/fstab
wget https://raw.githubusercontent.com/nxmup/AutoInstall/master/chroot.sh
cp chroot.sh /mnt
chmod +x /mnt/chroot.sh
arch-chroot /mnt /bin/bash -c "./chroot.sh"


echo "Root password is: rootpasswd, please use command: passwd root  change your password immediately!!!!"
echo "Default language is en_US, please change it from /etc/locale.conf if u want."
echo "Default timezone is Asia/Shanghai, change it if u want."
