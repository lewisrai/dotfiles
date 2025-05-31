#!/usr/bin/env bash


packages=(
    "asusctl"
    "blueman"
    "brightnessctl"
    "discord"
    "dunst"
    "hypridle"
    "hyprland"
    "hyprlock"
    "hyprpaper"
    "hyprpolkitagent"
    "imv"
    "lazygit"
    "libreoffice-fresh"
    "librewolf"
    "mpv"
    "ncspot"
    "nm-connection-editor"
    "nvim"
    "nwg-look"
    "obs-studio"
    "otf-firamono-nerd"
    "powertop" 
    "proton-vpn-gtk-app"
    "rofi-wayland"
    "supergfxctl"
    "uwsm"
    "vpl-gpu-rt"
    "v4l2loopback-dkms"
    "waybar"
    "xdg-desktop-portal-hyprland"
    "yazi"
)


sudo pacman -Syu --needed --noconfirm

sudo sed -i -e "s/plymouth //" /etc/mkinitcpio.conf
sudo sed -i -e "s/quiet nowatchdog/quiet rcutree.enable_rcu_lazy=1 ipv6.disable=1 nowatchdog/" /etc/default/limine

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

printf "[Unit]\nDescription=Powertop tunings\n\n[Service]\nType=oneshot\nRemainAfterExit=yes\nExecStart=/usr/bin/powertop --auto-tune\n\n[Install]\nWantedBy=multi-user.target\n" | sudo tee -i /etc/systemd/system/powertop.service > /dev/null

sudo systemctl enable --now powertop.service
sudo systemctl enable --now supergfxd
sudo systemctl --user --global enable hypridle.service
sudo systemctl --user --global enable hyprpolkitagent.service


sudo sed -i -e "s/Hybrid/Integrated/" /etc/supergfxd.conf
sudo sed -i -e "s/None/Asus/" /etc/supergfxd.conf

echo "After reboot, configure discord, git config --global user.email/name, gtk, librewolf, obs-studio"
