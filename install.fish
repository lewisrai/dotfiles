#!/usr/bin/env fish

if not fish_is_root_user
	echo Run this script as root!
	exit
end


pacman -Syu --needed --noconfirm

echo Remove plymouth from /etc/mkinitcpio.conf
echo Edit kernel cmdline in /etc/default/limine, add rcutree.enable_rcu_lazy=1, add ipv6.disable=1
read

limine-mkinitcpio

pacman -S asusctl brightnessctl hyprland hyprpaper lazygit libreoffice-fresh librewolf ncspot nvim proton-vpn-gtk-app rofi-wayland supergfxctl swww uwsm yay yazi --needed --noconfirm

yay --aur -Sy

asusctl -c 80
asusctl aura static -c ff00ff
asusctl aura-power keyboard -a

systemctl enable --now supergfxd

powerprofilesctl configure-battery-aware --disable
powerprofilesctl set power-saver

git clone https://github.com/lewisrai/nvim
mv nvim ../

echo Configure librewolf
echo Configure git config --global user.name/email
echo Configure supergfxd at /etc/supergfxd.conf
read

yay --aur -S ags-hyprpanel-git --needed --noconfirm
yat --aur -S rose-pine-hyprcursor --needed --noconfirm

systemctl reboot
