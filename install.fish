#!/usr/bin/env fish

if not fish_is_root_user
	echo Run this script as root!
	exit
end


pacman -Syu --needed --noconfirm

echo Remove plymouth from /etc/mkinitcpio.conf
echo Edit kernel cmdline in /etc/default/limine, add rcutree.enable_rcu_lazy=1, ipv6.disable=1
read

touch /etc/systemd/zram-generator.conf

pacman -Rsn plymouth cachyos-plymouth-theme --noconfirm

limine-mkinitcpio

pacman -S asusctl brightnessctl discord hyperidle hyprland hyprlock hyprpaper imv lazygit libreoffice-fresh librewolf mpv ncspot nvim obs-studio proton-vpn-gtk-app rofi-wayland supergfxctl swww uwsm vpl-gpu-rt v4l2loopback-dkms xdg-desktop-portal-hyprland yazi --needed --noconfirm

asusctl -c 80
asusctl aura static -c b4befe
asusctl aura-power keyboard -a

systemctl enable --now supergfxd
systemctl --user enable --now hypridle.service

powerprofilesctl configure-battery-aware --disable
powerprofilesctl set power-saver

paru -Syua
paru -Sa ags-hyprpanel-git hyprshot rose-pine-hyprcursor --needed --noconfirm

echo Configure supergfxd at /etc/supergfxd.conf
echo After reboot, configure discord, git config --global user.email/name, librewolf, obs-studio
read

systemctl reboot
