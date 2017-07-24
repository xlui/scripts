# AutoInstall
scripts to do auto install works.
#### now includes:
1. ArchLinux base system install
> Please make sure you have **parted** and **mounted** before run AutoInstall scripts.  
> 
> Please make sure you have a **good network**.  
> 
> Please note, this script will add [archlinuxcn](http://mirrors.ustc.edu.cn/archlinuxcn/) to pacman.conf and will reset mirrorlist to [ustc mirror](http://mirrors.ustc.edu.cn/archlinux).  
> 
> By default, your <u>language environment</u> will be set to **en_US.UTF-8**, and you can change it through file `/etc/locale.conf`  .
> 
> By default, your <u>timezone</u> will be set to **Asia/Shanghai**, and you can change it use command below:  
` ln -sf /usr/share/zoneinfo/YOURTIMEZONE /etc/localtime`  
` hwclock --systohc --local`  
>
> By default, your <u>hostname</u> is **ArchLinux**, and you can change is through file `/etc/hostname`.
> 
> By default, <u>root's password</u> is **rootpasswd**, please change it after the scripts stop immediately! ! !
> 
> Software Intalled: vim net-tools dnsutils git grub os-prober ntfs-3g dialog wpa_supplicant
> 
> At last, this script will enable **dhcpcd** on boot.