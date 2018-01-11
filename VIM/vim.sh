#!/bin/bash
default_dir="/etc/"
URL="https://raw.githubusercontent.com/xlui/Configs/master/vimrc"


# detect permission
if [ "$UID" -ne 0 ]; then
	echo "You must be root to run this script."
	exit 0
fi


# Get folder of `vimrc`
if [ -f "${default_dir}/vimrc"  ]; then
	dir=${default_dir}
else
	until [ -f "${vimrc_location}/vimrc" ]; do
		read -p "Please input the folder of vimrc(e.g. if the path of your vimrc is /etc/vimrc, you should input /etc): " vimrc_location
	done
	dir=${vimrc_location}
fi


# backup and update
mv ${dir}/vimrc ${dir}/vimrc_bak
wget -P ${dir} $URL
if [ $? -eq 0  ]; then
	echo "All things done!"
	exit 0
else
	echo "Maybe your network is not good, please run this script again!"
	exit 1
fi
