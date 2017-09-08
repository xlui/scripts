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

# base software
pacman -S xorg-server xorg-xinit xf86-video-nouveau xf86-video-vesa xf86-input-synaptics --noconfirm
if [ $? -ne 0  ]; then
	Error "During install x-server, error occured! please run this script again!"
fi

# gnome
pacman -S gnome gnome-extra gdm --noconfirm
if [ $? -ne 0  ]; then
	Error "During install gnome, error occured! This may because of your network!"
fi
systemctl enable gdm

# daily user
read -p "Please input the name of daily user: " username
read -p "Please input the password of daily user: " password
echo "$username":"$password" | chpasswd


echo "Install Complete! Note that if your graphics card is not nvidia, you should install drive software yourself!"