#!/bin/bash
git_repo="https://raw.githubusercontent.com/xlui/AutoInstall/master/ArchLinux/"

Error() {
	echo
	echo
	echo "Error occured!"
	echo "${1}"
	exit 2
}

echo 'Checking mounted /dev/sda or not....'
sleep 2
echo "This script will not part or mount for you!!!"
echo "Please make sure you have parted and mounted already!!!"
mount | grep sda
if [ $? -ne 0  ]; then
	Error "Please mount before run this script!"
fi

echo
echo
echo 'Updating pacman.conf and mirrorlist....'
echo "This script will add ArchLinuxcn source to pacman's conf"
echo "and change the content of /etc/pacman.d/mirrorlist to mirrors.tuna.tsinghua.edu.cn"
# pacman.conf
pacman_conf="/etc/pacman.conf"
pacman_mirrorlist="/etc/pacman.d/mirrorlist"
cat /etc/pacman.conf | grep archlinuxcn > /dev/null
if [ $? -ne 0  ]; then
	echo "[archlinuxcn]" >> $pacman_conf
	echo "SigLevel = Optional TrustAll" >> $pacman_conf
	echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> $pacman_conf
fi
# mirrorlist
echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' > $pacman_mirrorlist


# update database and install base system
echo
echo
echo "Updating source and install base system...."
echo "Please make sure you have a good network!!!"

read -p "continue(y/n) ?" queren
if [ "${queren}" != "y"  ]; then
	exit 1
fi

pacman -Syy
if [ $? -ne 0 ]; then
	Error "Bad network! Run the script again!"
fi

pacstrap /mnt base base-devel
if [ $? -ne 0  ]; then
	Error "Bad network! Run the script again!"
fi


# generate fstab and get chroot script to run
echo
echo
echo "Generating fstab and prepare to chroot...."
genfstab -U -p /mnt >> /mnt/etc/fstab
wget $git_repo"chroot.sh"
mv chroot.sh /mnt
chmod +x /mnt/chroot.sh
arch-chroot /mnt /bin/bash -c "bash chroot.sh"

echo "Root password is: rootpasswd, please use command: passwd root to change your password immediately!!!!"
