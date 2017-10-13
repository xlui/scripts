#!/bin/bash

Error () {
	echo "Error occured!"
	echo "${1}"
	exit 1
}

# configure language settings
echo "Configure language"
cp /etc/locale.gen /tmp/locale.gen
cat /tmp/locale.gen | sed '/en_US\.UTF-8\ UTF-8/d' | sed '/zh_CN\ GB2312/d' | sed '/zh_CN\.GBK\ GBK/d' | sed '/zh_CN\.UTF-8\ UTF-8/d' > /etc/locale.gen
rm /tmp/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.GBK GBK" >> /etc/locale.gen
echo "zh_CN GB2312" >> /etc/locale.gen
locale-gen

# set timezone info
echo "Set time zone info"
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc --local

# hostname and password
echo "Change hostname and root password"
echo "ArchLinux" > /etc/hostname
echo root:rootpasswd | chpasswd

# archlinuxcn repository
echo Add archlinuxcn repositories
pacman_conf="/etc/pacman.conf"
cat /etc/pacman.conf | grep archlinuxcn
if [ $? -ne 0  ]; then
	echo "[archlinuxcn]" >> $pacman_conf
	echo "SigLevel = Optional TrustAll" >> $pacman_conf
	echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> $pacman_conf
fi

# sync databases
pacman -Syy
if [ $? -ne 0  ]; then
	Error "Error during sync the repositories, this error occurs may because your network. Please chroot and run this script again to try to solve this error"
fi

echo "Install base softwares and configure grub"
pacman -S vim net-tools dnsutils git grub os-prober ntfs-3g dialog wpa_supplicant openssh wget --noconfirm
if [ $? -ne 0  ]; then
	Error "Error during install the base softwares, please chroot and run this script again to try to solve"
fi

# configure UEFI or Legacy
grub() {
	read -p "what's your bootload mode(uefi/legacy)?" BootMode
	case $BootMode in
		uefi | UEFI)
			echo "You choose UEFI mode"
			echo "Installing efibootmgr"
			pacman -S efibootmgr --noconfirm
			read -p "please input the mount path you mount EFI partition(eg. if you use this command to mount: mount /dev/sda1 /boot/efi; you should input: /boot/efi):" EFI_PATH
			grub-install --target=x86_64-efi --efi-directory=$EFI_PATH --bootloader-id=grub --recheck
			if echo $?; then
				return 1
			fi
			;;
		legacy | LEGACY | l)
			echo "You choose LEGACY mode"
			grub-install --target=i386-pc --recheck /dev/sda
			if echo $?; then
				return 1
			fi
			;;
		*)
			echo "Unknown choosen. please choose again"
			return 1
			;;
	esac
}

while grub 
do
	echo "Install Failed. Unknown reason, try again!"
done

grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable dhcpcd

# install desktop or not?
read -p "Would you like to install a desktop environment now(y/n)?" sure
if [ ${sure} == "y" ]; then
	wget https://raw.githubusercontent.com/nxmup/AutoInstall/master/choose.sh
	chmod +x choose.sh
	./choose.sh
	rm choose.sh
fi

exit 0
