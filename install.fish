#!/usr/bin/env fish

if fish_is_root_user
	echo "Do not run this script as root!"
	exit
end


sudo pacman -Syu --needed --noconfirm

echo Remove plymouth from /etc/mkinitcpio.conf
echo Edit kernel cmdline in /etc/default/limine, add rcutree.enable_rcu_lazy=1, ipv6.disable=1
read

sudo touch /etc/systemd/zram-generator.conf

sudo pacman -Rsn plymouth cachyos-plymouth-theme --noconfirm

sudo limine-mkinitcpio

sudo pacman -S asusctl brightnessctl discord dunst hypridle hyprland hyprlock hyprpaper imv lazygit libreoffice-fresh librewolf mpv ncspot nvim obs-studio otf-firamono-nerd proton-vpn-gtk-app rofi-wayland supergfxctl uwsm vpl-gpu-rt v4l2loopback-dkms waybar xdg-desktop-portal-hyprland yazi --needed --noconfirm

paru -Syua
paru -Sa hyprshot rose-pine-hyprcursor --needed --noconfirm

asusctl -c 80
asusctl aura static -c b4befe
asusctl aura-power keyboard -a

sudo systemctl enable --now supergfxd
sudo systemctl --user enable --now hypridle.service

powerprofilesctl configure-battery-aware --disable
powerprofilesctl set power-saver

echo "Configure supergfxd at /etc/supergfxd.conf"
echo "After reboot, configure discord, git config --global user.email/name, librewolf, obs-studio"
read
