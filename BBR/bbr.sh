#!/bin/bash


echo "import public key"
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

echo "install elrepo source"
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

echo "install the lastest kernel"
yum --enablerepo=elrepo-kernel install kernel-ml -y

echo "update grub"
grub2-mkconfig -o /boot/grub2/grub.cfg

echo "get the latest kernel's information"
latest=`cat /boot/grub2/grub.cfg | grep CentOS | head -1 | awk -F\' '{print $2}'`

echo "set the latest kernel to be default boot option"
grub2-set-default "$latest"

echo "list boot sequence."
echo "if the default boot kernel is not the latest kernel, you should set it by yourself"
grub2-editenv list
sleep 2

echo "regenerate grub config file"
grub2-mkconfig -o /boot/grub2/grub.cfg

echo "downloading after_reboot.sh"
wget https://raw.githubusercontent.com/nxmup/AutoInstall/master/BBR/after_reboot.sh
echo "Please reboot to bring the latest kernel into effect"
echo "And after you reboot, please run the after_reboot.sh"
exit
