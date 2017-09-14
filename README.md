# AutoInstall
Spend a lot of time installing system of do some other things is unworthy, so I attempt to write a series of scripts to do this thing automatically for me.  

### now includes:
1. ArchLinux base system install
> Please make sure you have **parted** and **mounted** before run AutoInstall scripts. Different from others, this script will not do this for you.  
>
> This script privides to method to use grub: UEFI and LEGACY  
> before running command `grub-install`, you must choose one mode. Please make choice based on your BIOS Mode.
> 
> Please make sure you have a **good network**.  
> 
> Please note that, this script will add [archlinuxcn](http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/) to pacman.conf and will reset mirrorlist to [ustc mirror](http://mirrors.tuna.tsinghua.edu.cn/archlinux).  
> 
> By default, your <u>language environment</u> will be set to **en_US.UTF-8**, and you can change it through file `/etc/locale.conf`  .
> 
> By default, your <u>timezone</u> will be set to **Asia/Shanghai**, and you can change it use command below:  
` ln -sf /usr/share/zoneinfo/YOURTIMEZONE /etc/localtime`  
` hwclock --systohc --local`  
>
> By default, your <u>hostname</u> will be set as **ArchLinux**, and you can change is through file `/etc/hostname`.
> 
> By default, <u>root's password</u> is **rootpasswd**, please change it after the scripts stop immediately! ! !
> 
> Software Intalled: vim net-tools dnsutils git grub os-prober ntfs-3g dialog wpa_supplicant openssh wget
> 
> At last, this script will enable **dhcpcd** on boot.

2. Auto Open BBR acceleration
> Auto open bbr acceleration script, just download the bbr.sh script and run to set bbr acceleration automatically

<br>

### How to use?
1. Arch auto-install scripts  

After partition your disk and mount it, just download the installArch script, give the scritp run authority and run it.
```bash
wget https://raw.githubusercontent.com/nxmup/AutoInstall/master/installArch.sh
chmod +x installArch.sh
./installArch.sh
```

2. BBR acceleration auto-set scripts

Just download the bbs.sh and run.
```bash
wget https://raw.githubusercontent.com/nxmup/AutoInstall/master/BBR/bbr.sh
chmod +x bbr.sh
./bbr.sh
```
