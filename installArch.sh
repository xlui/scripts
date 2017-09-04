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
	exit 2
}

# make sure parted and mounter before
echo "This script will not part or mount for you!!!"
echo "Please make sure you have parted and mounted already!!!"
mount | grep sda
if [ $? -ne 0  ]; then
	Error "Please mount before run this script!"
fi

# update pacman.conf and mirrorlist
pacman_conf="/etc/pacman.conf"
pacman_mirrorlist="/etc/pacman.d/mirrorlist"
echo "Add ArchLinuxcn source to pacman's conf, and change /etc/pacman.d/mirrorlist to the tsinghua"
# pacman.conf
cat /etc/pacman.conf | grep archlinuxcn
if [ $? -ne 0  ]; then
	echo "[archlinuxcn]" >> $pacman_conf
	echo "SigLevel = Optional TrustAll" >> $pacman_conf
	echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> $pacman_conf
fi
# mirrorlist
echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' > $pacman_mirrorlist


# update database and install base system
echo "Update source and install base system"
echo "Please make sure you have a good network!!!"
Continue 
pacman -Syy
if [ $? -ne 0 ]; then
	Error "During update the source. This error's occure may due to your bad network! Please run this script again to try to deal with this error."
fi
pacstrap /mnt base base-devel
if [ $? -ne 0  ]; then
	Error "During install the base system, please run the script again to try to deal with this error"
fi


# generate fstab and get chroot script to run
echo "Generate fstab and chroot"
genfstab -U -p /mnt >> /mnt/etc/fstab
wget https://raw.githubusercontent.com/nxmup/AutoInstall/master/chroot.sh
cp chroot.sh /mnt
chmod +x /mnt/chroot.sh
arch-chroot /mnt /bin/bash -c "./chroot.sh"
# arch-chroot: -c option enable you run script after chroot
rm chroot.sh /mnt/chroot.sh

echo "Root password is: rootpasswd, please use command: passwd root  change your password immediately!!!!"
echo "Default language is en_US, please change it from /etc/locale.conf if u want."
echo "Default timezone is Asia/Shanghai, change it if u want."
