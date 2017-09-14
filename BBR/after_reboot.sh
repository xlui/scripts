#!/bin/bash

echo "Now let's start configuring bbr"
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sleep 1

echo "Test bbr open or not"
sysctl net.ipv4.tcp_available_congestion_control
lsmod | grep bbr
sleep 1


echo "Not setting yum to skip updating kernel"
echo "exclude=kernel*" >> /etc/yum.conf
echo "exclude=centos-release*" >> /etc/yum.conf


echo "All things done!"
exit

