#!/bin/bash

Error() {
	echo 'Error occured!'
	echo "${1}"
	exit 1
}

# Authentication
if [ $UID -ne 0 ]; then
	echo You mast be root to run this script!
fi

# Detect archlinuxcn repository
pacman_conf="/etc/pacman.conf"
cat /etc/pacman.conf | grep archlinuxcn
if [ $? -ne 0  ]; then
	echo "[archlinuxcn]" >> $pacman_conf
	echo "SigLevel = Optional TrustAll" >> $pacman_conf
	echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> $pacman_conf
fi

# install x-server
pacman -S xorg-server xorg-xinit --noconfirm
if [ $? -ne 0  ]; then
	Error "During install x-server, error occured! please run this script again!"
fi

# install xfce4
pacman -S xfce4 xfce4-goodies lxdm networkmanager network-manager-applet --noconfirm
if [ $? -ne 0  ]; then
	Error "During install xfce4, error occured! please run this script again!"
fi
systemctl enable NetworkManager
cp /etc/lxdm/lxdm.conf /tmp/lxdm.conf
sed '/session=/d' /tmp/lxdm.conf | sed '/session/a\session=\/usr\/bin\/startxfce4' > /etc/lxdm/lxdm.conf
rm /tmp/lxdm.conf
systemctl enable lxdm

pacman -S xf86-video-nouveau xf86-input-synaptics alsa-utils fcitx-im fcitx-configtool --noconfirm
if [ $? -ne 0  ]; then
	Error "During install base software, error occured! please run this script again!"
fi
echo 'export GTK_IM_MODULE=fcitx' >> /etc/profile
echo 'export QT_IM_MODULE=fcitx' >> /etc/profile
echo 'export XMODIFIERS="@im=fcitx"' >> /etc/profile
pacman -S fcitx-sogoupinyin --noconfirm

pacman -S gvfs gvfs-mtp ntfs-3g ttf-dejavu wqy-microhei wqy-zenhei --noconfirm

echo "All things done!"
echo "You should create a normal user for dialy use"
echo "Please create now"
