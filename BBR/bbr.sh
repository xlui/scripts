#!/bin/bash

echo "Now let's start configure bbr..."
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
echo "Now let's start configure bbr...done"

echo "Testing bbr..."
sysctl net.ipv4.tcp_available_congestion_control
lsmod | grep bbr
echo "Testing bbr...done"
