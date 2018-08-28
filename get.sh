echo 'updating project....'
git pull

echo 'removing exist files....'
cd ..
rm -f arch bbr vim ss

echo 'copying new scripts....'
cp AutoInstall/ArchLinux/arch.sh arch
cp AutoInstall/BBR/bbr.sh bbr
cp AutoInstall/VIM/vim.sh vim
wget -O ss https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-libev.sh
