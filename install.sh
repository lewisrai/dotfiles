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
sudo sed -i -e 's/quiet nowatchdog/quiet ipv6.disable=1 rcutree.enable_rcu_lazy=1 nowatchdog/' /etc/default/limine

sudo touch /etc/systemd/zram-generator.conf

sudo pacman -Rsn plymouth cachyos-plymouth-bootanimation --noconfirm

luks='s/                    echo "A password is required to access the ${cryptname} volume:"/'
luks+='                    echo -e "Owner: '$1'\\n\\nPassword required for ${cryptname} volume:"/'

sudo sed -i -e "$luks" /usr/lib/initcpio/hooks/encrypt

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

sudo systemctl enable --now powertop.service supergfxd
sudo systemctl --user --global enable hypridle.service hyprpolkitagent.service

sudo sed -i -e 's/Hybrid/Integrated/' -e 's/None/Asus/' /etc/supergfxd.conf

rm -rf ~/.config/fish

chsh -s /usr/bin/bash
