#!/usr/bin/env bash


packages=(
    '7zip'
    'asusctl'
    'blueman'
    'brightnessctl'
    'dunst'
    'hypridle'
    'hyprland'
    'hyprlock'
    'hyprpaper'
    'hyprpolkitagent'
    'imv'
    'lazygit'
    'libreoffice-fresh'
    'librewolf'
    'mpv'
    'ncspot'
    'nm-connection-editor'
    'nvim'
    'nwg-look'
    'obs-studio'
    'otf-firamono-nerd'
    'powertop'
    'proton-vpn-gtk-app'
    'rofi-wayland'
    'steam' 
    'supergfxctl'
    'uwsm'
    'v4l2loopback-dkms'
    'vpl-gpu-rt'
    'waybar'
    'xdg-desktop-portal-hyprland'
    'yazi'
)


sudo pacman -Syu --needed --noconfirm

sudo sed -i -e 's/plymouth //' /etc/mkinitcpio.conf
sudo sed -i -e 's/quiet nowatchdog/quiet ipv6.disable=1 rcutree.enable_rcu_lazy=1 split_lock_detect=off nowatchdog/' /etc/default/limine

sudo touch /etc/systemd/zram-generator.conf

sudo pacman -Rsn plymouth cachyos-plymouth-bootanimation --noconfirm

sudo limine-mkinitcpio

sudo pacman -S ${packages[@]} --needed --noconfirm

paru -Syua
paru -Sa catppuccin-gtk-theme-mocha hyprshot rose-pine-hyprcursor --needed --noconfirm

asusctl -c 80
asusctl aura static -c b4befe
asusctl aura-power keyboard -a

powerprofilesctl configure-battery-aware --disable
powerprofilesctl set power-saver

printf '[Unit]\nDescription=Powertop tunings\n\n[Service]\nType=oneshot\nRemainAfterExit=yes\nExecStart=/usr/bin/powertop --auto-tune\n\n[Install]\nWantedBy=multi-user.target' | sudo tee -i /etc/systemd/system/powertop.service > /dev/null

sudo systemctl enable --now powertop.service
sudo systemctl enable --now supergfxd
sudo systemctl --user --global enable hypridle.service
sudo systemctl --user --global enable hyprpolkitagent.service


sudo sed -i -e 's/Hybrid/Integrated/' /etc/supergfxd.conf
sudo sed -i -e 's/None/Asus/' /etc/supergfxd.conf

luks='s/                    echo "A password is required to access the ${cryptname} volume:"/'
luks+='                    echo "Owner: '$1'"\n'
luks+='                    echo ""\n'
luks+='                    echo "Password required for ${cryptname} volume:"/'

sudo sed -i -e $luks /usr/lib/initcpio/hooks/encrypt

rm -rf ~/.config/fish

chsh -s /usr/bin/bash

echo 'After reboot, git config --global user.email/name, gtk, librewolf, obs-studio'
