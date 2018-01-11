# AutoInstall
Spend a lot of time installing system of do some other things is unworthy, so I have wrote some scripts to do this thing automatically.  

## Now Includes:

- [Install ArchLinux](#archLinux)
- [Open BBR automatically](#bbr)
- [Vimrc](#vimrc)
- [Usage](#usage)
- [LICENSE](#license)


## ArchLinux

The script will do all installation things without partition, so **please make sure you have parted and mounted** before run script `installArch.sh`. 
>
> You can choose which method to boot: **UEFI** or **LEGACY**, just follow the prompts.
> 
> Please make sure you have a **good network**.  
> 
> Please note that, this script will add [archlinuxcn](http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/) to pacman.conf and will delete the origin mirrorlists and set it to [ustc mirror](http://mirrors.tuna.tsinghua.edu.cn/archlinux).  
> 
> By default, your language environment will be set to `en_US.UTF-8`, and you can change it through file `/etc/locale.conf`.
> 
> By default, your timezone will be set to `Asia/Shanghai`, and you can change it use command below:  
` ln -sf /usr/share/zoneinfo/YOURTIMEZONE /etc/localtime`  
` hwclock --systohc --local`  
>
> By default, your hostname will be set as `ArchLinux`, and you can change is through file `/etc/hostname`.
> 
> By default, root's password is `rootpasswd`, please change it after the scripts stop immediately! ! !
> 
> Software Intalled: vim net-tools dnsutils git grub os-prober ntfs-3g dialog wpa_supplicant openssh wget
> 
> At last, you can choose to install a desktop environment or not.

## BBR

> Auto open bbr acceleration script, just download the `bbr.sh` script and run to set bbr acceleration automatically

## Vimrc

This script will set some common options in vim, in order to create a good experience in server(always command line). See details: [vimrc](VIM/vimrc)


<br>

## Usage

1. Arch auto-install script

Make sure you have parted and mounted you disk properly!

```bash
curl -SL https://raw.githubusercontent.com/xlui/AutoInstall/master/ArchLinux/installArch.sh | bash
```

2. BBR acceleration auto-set script

```bash
curl -SL https://raw.githubusercontent.com/xlui/AutoInstall/master/BBR/bbr.sh | bash
```

3. vimrc

```bash
curl -SL https://raw.githubusercontent.com/xlui/AutoInstall/master/VIM/vim.sh | bash
```

## LICENSE

MIT
