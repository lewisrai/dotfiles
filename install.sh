#!/usr/bin/env bash


packages=(
    '7zip'
    'asusctl'
    'blueman'
    'brightnessctl'
    'dunst'
    'gvfs' 
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
    'sbctl' 
    'supergfxctl'
    'thunar' 
    'uwsm'
    'v4l2loopback-dkms'
    'vpl-gpu-rt'
    'waybar'
    'xdg-desktop-portal-hyprland'
)


sudo pacman -Syu --needed --noconfirm

sudo sed -i -e 's/plymouth //' /etc/mkinitcpio.conf
sudo sed -i -e 's/quiet nowatchdog/quiet ipv6.disable=1 rcutree.enable_rcu_lazy=1 nowatchdog/' /etc/default/limine

sudo touch /etc/systemd/zram-generator.conf

sudo pacman -Rsn plymouth cachyos-plymouth-bootanimation --noconfirm

sudo limine-mkinitcpio

sudo pacman -S "${packages[@]}" --needed --noconfirm

paru -Syua
paru -Sa catppuccin-gtk-theme-mocha hyprshot rose-pine-hyprcursor --needed --noconfirm

asusctl -c 80
asusctl aura static -c b4befe
asusctl aura-power keyboard -a

powerprofilesctl configure-battery-aware --disable
powerprofilesctl set power-saver

echo -e '[Unit]\nDescription=Powertop tunings\n\n[Service]\nType=oneshot\nRemainAfterExit=yes\nExecStart=/usr/bin/powertop --auto-tune\n\n[Install]\nWantedBy=multi-user.target' | sudo tee -i /etc/systemd/system/powertop.service > /dev/null

sudo sed -i -e 's/Hybrid/Integrated/' -e 's/None/Asus/' /etc/supergfxd.conf

sudo systemctl enable --now powertop.service supergfxd
sudo systemctl --user --global enable hypridle.service hyprpolkitagent.service

sudo sbctl create-keys
sudo sbctl enroll-keys -m
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
sudo limine-enroll-config

rm -rf ~/.config/fish
rm .bash_logout 

chsh -s /usr/bin/bash
