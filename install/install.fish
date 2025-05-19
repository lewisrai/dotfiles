#!/usr/bin/env fish

if not fish_is_root_user
	echo Run this script as root!
	exit
end

cp ../nvidia/blacklist-nouveau.conf /etc/modprobe.d
cp ../nvidia/00-remove-nvidia.rules /etc/udev/rules.d

echo Remove plymouth from /etc/mkinitcpio.conf!
read

pacman -Syu
pacman -Rsn plymouth cachyos-plymouth-theme
pacman -S asusctl hyprland librewolf nvim uwsm yay --needed

yay -Syu
