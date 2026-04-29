packages=(
    '7zip'
    'asusctl'
    'audacious'
    'bemenu'
    'bemenu-wayland'
    'biber'
    'biome'
    'blueman'
    'brightnessctl'
    'dunst'
    'easyeffects'
    'foot'
    'fcitx5-im'
    'fcitx5-mozc'
    'gimp'
    'gvfs'
    'gvfs-mtp'
    'helium-browser-bin'
    'hunspell-en_gb'
    'hypridle'
    'hyprland'
    'hyprlock'
    'hyprshot'
    'imv'
    'isoimagewriter'
    'jedi-language-server'
    'lact'
    'lazygit'
    'libreoffice-fresh'
    'lsp-plugins-lv2'
    'lua-language-server'
    'mpv'
    'network-manager-applet'
    'nvim'
    'nwg-look'
    'obs-studio'
    'obsidian'
    'opencode'
    'otf-firamono-nerd'
    'proton-cachyos-slr'
    'proton-vpn-gtk-app'
    'pwvucontrol'
    'python-openai'
    'python-pygame'
    'qt6ct'
    'rust'
    'rust-analyzer'
    'sbctl'
    'scx-scheds'
    'scx-tools'
    'steam'
    'supergfxctl'
    'texstudio'
    'texlive-meta'
    'thunar' 
    'tree-sitter-bash'
    'tree-sitter-cli'
    'tree-sitter-javascript'
    'tree-sitter-python'
    'tree-sitter-rust'
    'ty'
    'vesktop-bin'
    'waybar'
    'xdg-desktop-portal-hyprland'
    'cmd-polkit-git'
    'llama.cpp'
    'osu-lazer-bin'
    'wbg'
)

mkdir ~/.icons/

mv -f .config/* ~/.config/
mv -f .icons/* ~/.icons/
mv -f .local/share/* ~/.local/share/
mv -f *. ~/

rm -f .bash_logout

sudo mkdir -p /usr/local/share/kbd/keymaps/
sudo 7z x /usr/share/kbd/keymaps/i386/qwerty/uk.map.gz -o/usr/local/share/kbd/keymaps/
sudo sed -i -e 's|Caps_Lock|Escape|' /usr/local/share/kbd/keymaps/uk.map
sudo sed -i -e 's|uk|/usr/local/share/kbd/keymaps/uk.map|' /etc/vconsole.conf

cat << 'EOF' | sudo tee -i /boot/limine.conf
term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
term_background: 1e1e2e
term_foreground: cdd6f4
term_background_bright: 585b70
term_foreground_bright: cdd6f4
timeout: 0
default_entry: 2
EOF

sudo sed -i -e 's|base ||' -e 's|udev|systemd|' -e 's|consolefont ||' -e 's|plymouth ||' /etc/mkinitcpio.conf
sudo sed -i -e 's|"quiet|"vt.default_red=30,243,166,249,137,203,137,205,30,243,166,249,137,203,137,205 vt.default_grn=30,139,227,226,180,166,220,214,30,139,227,226,180,166,220,214 vt.default_blu=46,168,161,175,250,247,235,244,46,168,161,175,250,247,235,244 vt.cur_default=0x641517 i915.force_probe=!46a6 xe.force_probe=46a6 ipv6.disable=1 rcutree.enable_rcu_lazy=1 split_lock_detect=off systemd.zram=0 quiet|' -e 's|splash ||' /etc/default/limine

sudo pacman -Rsn cachyos-plymouth-bootanimation pavucontrol plymouth switcheroo-control --noconfirm

paru -Syu "${packages[@]}"

asusctl -c 80
asusctl aura static -c f5c2e7
asusctl aura-power keyboard -a

sudo mkdir /etc/scx_loader/

cat << 'EOF' | sudo tee -i /etc/scx_loader/config.toml
default_sched = "scx_lavd"
default_mode = "PowerSave"
EOF

cat << 'EOF' | sudo tee -i /etc/systemd/system/no-turbo.service
[Unit]
Description=no-turbo

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash -c 'echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo'

[Install]
WantedBy=multi-user.target
EOF

cat << 'EOF' | sudo tee -i /etc/systemd/system/set-powersave.service
[Unit]
Description=set-powersave

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash -c 'echo auto | tee /sys/bus/usb/devices/3-9/power/control /sys/bus/pci/devices/0000:00:0a.0/power/control /sys/bus/pci/devices/0000:00:00.0/power/control /sys/bus/pci/devices/0000:02:00.0/power/control /sys/bus/pci/devices/0000:03:00.0/power/control'

[Install]
WantedBy=multi-user.target
EOF

sudo sed -i -e 's|#AutoEnable=true|AutoEnable=false|' /etc/bluetooth/main.conf
sudo sed -i -e 's|Hybrid|Integrated|' -e 's|None|Asus|' -e 's|reboot": false|reboot": true|' /etc/supergfxd.conf

sudo systemctl enable no-turbo.service scx_loader.service set-powersave.service supergfxd.service
sudo systemctl --user --global enable hypridle.service

sudo sbctl create-keys
sudo sbctl enroll-keys
sudo limine-enroll-config
sudo limine-update
j
mv install.sh ~/
rm -rf ~/dotfiles/
