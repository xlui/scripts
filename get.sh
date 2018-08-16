echo 'updating project....'
git pull

echo 'removing exist files....'
cd ..
rm -f arch bbr vim

echo 'copying new scripts....'
cp AutoInstall/ArchLinux/arch.sh arch
cp AutoInstall/BBR/bbr.sh bbr
cp AutoInstall/VIM/vim.sh vim
