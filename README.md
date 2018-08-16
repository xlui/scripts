# AutoInstall

[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/xlui/AutoInstall)

Spend a lot of time installing a linux system(like archlinux which you should do it yourself) or doing some other bored things is unworthy, so I have wrote some scripts to do this thing automatically. What you should do is to download the script and run it and wait!

## Now Includes

- [Install ArchLinux](#archlinux)
- [Open BBR automatically](#bbr)
- [Vimrc](#vimrc)
- [Git Config](#git-config)
- [Usage](#usage)

## ArchLinux

The script will do all installation things without `partition`, so **please make sure you have parted and mounted** before run the script.
>
> You can choose which method to boot: **UEFI** or **LEGACY**, just follow the prompts.
>
> Please make sure you have a **good network**.
>
> Please note that, this script will add [archlinuxcn](http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/) to pacman.conf and will delete the origin mirrorlists and set it to [ustc mirror](http://mirrors.tuna.tsinghua.edu.cn/archlinux).  
>
> By default, your language environment will be set to `en_US.UTF-8`, and you can change it through file `/etc/locale.conf`.
>
> By default, your timezone will be set to `Asia/Shanghai`, and you can change it using commands below:  
` ln -sf /usr/share/zoneinfo/YOURTIMEZONE /etc/localtime`  
` hwclock --systohc --local`  
>
> By default, your hostname will be set as `ArchLinux`, and you can change is through changing file `/etc/hostname`.
>
> By default, root's password is `rootpasswd`, please change it after the scripts stop immediately! ! !
>
> Software will be Intalled: vim net-tools dnsutils git grub os-prober ntfs-3g dialog wpa_supplicant openssh wget
>
> At last, you can choose to install a desktop environment or not :).

## BBR

Automatical enable bbr acceleration script in **CentOS**, just download the `bbr.sh` script and run. This script will download the latest kernel and set it to the default booting kernel, so if you don't want to use the latest you may download it yourself and treat the script as a reference :).

## Vimrc

This script will set some common options in vim, in order to create a good experience in remote server(the environment is always command line only). See details about the config: [vimrc](VIM/vimrc)

## Git Config

Script to change git config can be destructive, so I just post my git config here:

```configuration
[alias]
    st = status
    lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative

[push]
    default = simple
```

have a good experience with git :smirk:

## Usage

1. Arch auto-install script

Make sure you have parted and mounted your disk properly!

```bash
wget https://sh.xlui.app/arch && chmod +x arch && bash arch
```

2. BBR acceleration auto-set script

```bash
wget https://sh.xlui.app/bbr && chmod +x bbr && bash bbr
```

3. vimrc

```bash
wget https://sh.xlui.app/vim && chmod +x vim && bash vim
```
