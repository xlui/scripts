#!/bin/bash
# this script is used to choose desktop to be installed

read -p "Please choose a desktop to install(gnome, xfce): " choosen

case $choosen in
	gnome)
		echo "Script for install gnome desktop isnot ok now"
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
