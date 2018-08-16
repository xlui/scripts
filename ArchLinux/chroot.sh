#!/bin/bash

Error() 
{
	echo
	echo
	echo "Error occured!"
	echo "${1}"
	exit 1
}

Configure_Language()
{
	echo "Configuring language...."
	cp /etc/locale.gen /tmp/locale.gen
	cat /tmp/locale.gen | sed '/en_US\.UTF-8\ UTF-8/d' | sed '/zh_CN\ GB2312/d' | sed '/zh_CN\.GBK\ GBK/d' | sed '/zh_CN\.UTF-8\ UTF-8/d' > /etc/locale.gen
	rm /tmp/locale.gen
	echo "LANG=en_US.UTF-8" > /etc/locale.conf
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
	echo "zh_CN.GBK GBK" >> /etc/locale.gen
	echo "zh_CN GB2312" >> /etc/locale.gen
	locale-gen
}

Configure_Time()
{
	echo
	echo
	echo "Setting time zone...."
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
}

Configure_HostnameRootPassword()
{
	echo
	echo
	echo "Changing hostname and root password...."
	echo "ArchLinux" > /etc/hostname
	echo root:rootpasswd | chpasswd
}

Configure_ArchLinuxCN()
{
	echo
	echo
	echo 'Adding archlinuxcn repositories'
	pacman_conf="/etc/pacman.conf"
	cat /etc/pacman.conf | grep archlinuxcn > /dev/null
	if [ $? -ne 0  ]; then
		echo "[archlinuxcn]" >> $pacman_conf
		echo "SigLevel = Optional TrustAll" >> $pacman_conf
		echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> $pacman_conf
	fi
}

Install_Base_Software()
{
	pacman -Syy
	if [ $? -ne 0  ]; then
		Error "Bad Network!!! Please run this script again!"
	fi

	echo
	echo
	echo "Installing base softwares and configure grub...."
	pacman -S vim net-tools dnsutils git grub os-prober ntfs-3g dialog wpa_supplicant openssh wget --noconfirm
	if [ $? -ne 0  ]; then
		Error "Bad network, chroot and try again!!!"
	fi
}

Grub()
{
	while :;do
		echo "what's your boot mode(uefi/legacy)?"
		read bootmode
		case $bootmode in
			uefi | UEFI | u)
				echo "You choose UEFI mode!"
				echo "Installing efibootmgr...."
				pacman -S efibootmgr --noconfirm
				echo "Please input the mount path you mount EFI partition(eg. if you use this command to mount: mount /dev/sda1 /boot/efi; you should input: /boot/efi)"
				read EFIpath
				grub-install --target=x86_64-efi --efi-directory=$EFIpath --bootloader-id=grub --recheck
				if [ $? -eq 0  ]; then
					break
				fi
				;;
			legacy | LEGACY | l)
				echo "You choose LEGACY mode"
				grub-install --target=i386-pc --recheck /dev/sda
				if [ $? -eq 0  ]; then
					break
				fi
				;;
			*)
				echo "Unknown choosen. please choose again"
				continue
				;;
		esac
	done
	
	grub-mkconfig -o /boot/grub/grub.cfg
	systemctl enable dhcpcd
}

Choose()
{
	echo "Would you like to install a desktop environment now(y/n)?"
	read choose
	if [ "${choose}" == "y" ]; then
		echo "Please choose a desktop environment to install(gnome, xfce):"
		read choosen
		if [ "${choosen}" == "gnome"  ]; then
			Gnome
		else if [ "${choosen}" == "xfce"  ]; then
			Xfce
		fi
		fi
	else
		echo
		echo "All things done."
		exit 0
	fi
}

Gnome()
{
	echo
	echo
	echo "Installing xorg and video driver and synaptics board driver...."
	Configure_ArchLinuxCN
	pacman -S xorg-server xorg-xinit xf86-video-nouveau xf86-video-vesa xf86-input-synaptics --noconfirm
	if [ $? -ne 0  ]; then
		Error "Bad network, try again!!!"
	fi

	echo
	echo
	echo "Installing gnome...."
	pacman -S gnome gnome-extra gdm --noconfirm
	if [ $? -ne 0  ]; then
		Error "Bad network, try again!!!"
	fi
	systemctl enable gdm
	systemctl enable NetworkManager

	Create_User

	echo
	echo "All things done."
}

Xfce()
{
	echo
	echo
	echo "Installing x-server...."
	pacman -S xorg-server xorg-xinit --noconfirm
	if [ $? -ne 0  ]; then
		Error "Bad network, try again!!!"
	fi
	
	echo "Installing xfce4...."
	pacman -S xfce4 xfce4-goodies lxdm networkmanager network-manager-applet
	if [ $? -ne 0  ]; then
		Error "Bad network, try again!!!"
	fi
	systemctl enable NetworkManager
	cp /etc/lxdm/lxdm.conf /tmp/lxdm.conf
	sed '/session=/d' /tmp/lxdm.conf | sed '/session/a\session=\/usr\/bin\/startxfce4' > /etc/lxdm/lxdm.conf
	rm /tmp/lxdm.conf
	systemctl enable lxdm
	
	echo "Installing drivers and fcitx...."
	pacman -S xf86-video-nouveau xf86-video-vesa xf86-input-synaptics alsa-utils fcitx-im fcitx-configtool --noconfirm
	if [ $? -ne 0  ]; then
		Error "Bad network, try again!!!"
	fi
	echo 'export GTK_IM_MODULE=fcitx' >> /etc/profile
	echo 'export QT_IM_MODULE=fcitx' >> /etc/profile
	echo 'export XMODIFIERS="@im=fcitx"' >> /etc/profile
	pacman -S fcitx-sogoupinyin --noconfirm

	echo "Installing base software...."
	pacman -S gvfs gvfs-mtp ntfs-3g ttf-dejavu wqy-microhei wqy-zenhei --noconfirm
	if [ $? -ne 0  ]; then
		Error "Bad network, try again!!!"
	fi

	Create_User

	echo
	echo "All things done."
}

Create_User()
{
	echo
	echo
	echo "Creating a normal user...."
	echo "Please input the new user's username:"
	read username
	echo "Please input the new user's password:"
	read password
	useradd -m "${username}"
	echo "${username}":"${password}" | chpasswd
}


############
#   start
############

Configure_Language
Configure_Time
Configure_HostnameRootPassword
Configure_ArchLinuxCN
Install_Base_Software
Grub
Choose

