#!/bin/bash
# this script is used to choose desktop to be installed

read -p "Please choose a desktop to install(gnome, xfce): " choosen

case $choosen in
	gnome)
		echo "You choose to install gnome!"
		wget https://raw.githubusercontent.com/nxmup/AutoInstall/master/gnome.sh
		chmod +x gnome.sh
		./gnome.sh
		rm gnome.sh
		;;
	xfce)
		echo "You choose to install xfce!"
		wget https://raw.githubusercontent.com/nxmup/AutoInstall/master/xfce4.sh
		chmod +x xfce4.sh
		./xfce4.sh
		rm xfce4.sh
		;;
	*)
		echo "Unknown choosen!"
		;;
esac
exit 0
