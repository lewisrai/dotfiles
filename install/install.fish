#!/usr/bin/env fish

if not fish_is_root_user
	echo Run this script as root!
	exit
end

echo Remove plymouth from /etc/mkinitcpio.conf
read

pacman -Syu
pacman -Rsn plymouth cachyos-plymouth-theme --noconfirm
pacman -S asusctl hyprland lazygit librewolf nvim rog-control-center supergfxctl yay --needed --noconfirm

systemctl enable --now supergfxd

yay -Syu
