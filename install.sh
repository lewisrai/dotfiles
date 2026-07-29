packages=(
    '7zip'
    'asusctl'
    'biber'
    'biome'
    'blueman'
    'brightnessctl'
    'bun'
    'easyeffects'
    'foot'
    'fcitx5-im'
    'fcitx5-mozc'
    'gnome-keyring'
    'gvfs'
    'gvfs-mtp'
    'helium-browser-bin'
    'hunspell-en_gb'
    'hypridle'
    'hyprshot'
    'impala'
    'imv'
    'isoimagewriter'
    'jedi-language-server'
    'kdenlive'
    'krita'
    'lazygit'
    'libreoffice-fresh'
    'llama-cpp'
    'lsp-plugins-lv2'
    'lua-language-server'
    'mango'
    'mpv'
    'nvim'
    'nwg-look'
    'obs-studio'
    'obsidian'
    'opencode'
    'otf-firamono-nerd'
    'pwvucontrol'
    'quickshell'
    'qt6ct'
    'rust'
    'rust-analyzer'
    'sbctl'
    'socat'
    'supergfxctl'
    'texstudio'
    'texlive-meta'
    'thunar' 
    'tree-sitter-cli'
    'ty'
    'wireguard-tools'
    'xdg-desktop-portal-wlr'
)

remove=(
    'cachyos-plymouth-bootanimation'
    'cachyos-plymouth-theme'
    'linux-cachyos-lts'
    'linux-cachyos-lts-headers'
    'linux-cachyos-lts-nvidia-open'
    'plymouth'
    'switcheroo-control'
)

rm -rf ~/.*

mv -f ~/dotfiles/* ~/
mv -f ~/dotfiles/.* ~/

cat << 'EOF' | sudo tee -i /boot/limine.conf
term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
term_background: 1e1e2e
term_background_bright: 585b70
term_foreground: cdd6f4
term_foreground_bright: cdd6f4
timeout: 0
quiet: yes
default_entry: 2

EOF

cat << 'EOF' | sudo tee -i /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=true
EOF

sudo sed -i -e 's|base ||' -e 's|plymouth ||' /etc/mkinitcpio.conf
sudo sed -i -e 's|"quiet|"vt.default_red=30,243,166,249,137,203,137,205,30,243,166,249,137,203,137,205 vt.default_grn=30,139,227,226,180,166,220,214,30,139,227,226,180,166,220,214 vt.default_blu=46,168,161,175,250,247,235,244,46,168,161,175,250,247,235,244 vt.cur_default=0x641517 i915.force_probe=!46a6 xe.force_probe=46a6 ipv6.disable=1 rcutree.enable_rcu_lazy=1 split_lock_detect=off systemd.zram=0 quiet|' -e 's|splash ||' /etc/default/limine

sudo pacman -Rsn "${remove[@]}" --noconfirm

sudo pacman -Syu "${packages[@]}" --noconfirm

sudo cp /usr/share/kbd/keymaps/i386/qwerty/uk.map.gz /usr/share/kbd/keymaps/uk-custom.map.gz
sudo gzip -d /usr/share/kbd/keymaps/uk-custom.map.gz
sudo sed -i -e 's|Caps_Lock|Escape|' /usr/share/kbd/keymaps/uk-custom.map
sudo gzip /usr/share/kbd/keymaps/uk-custom.map
sudo sed -i -e 's|uk|uk-custom|' /etc/vconsole.conf

asusctl battery limit 80
asusctl aura effect static --colour f5c2e7
asusctl aura power keyboard --awake

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
ExecStart=/bin/bash -c 'echo auto | tee /sys/bus/usb/devices/3-9/power/control /sys/bus/pci/devices/0000:00:00.0/power/control /sys/bus/pci/devices/0000:00:0a.0/power/control /sys/bus/pci/devices/0000:02:00.0/power/control'

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable --now no-turbo.service set-powersave.service supergfxd.service

sudo sed -i -e 's|#AutoEnable=true|AutoEnable=false|' /etc/bluetooth/main.conf
sudo sed -i -e 's|Hybrid|Integrated|' -e 's|None|Asus|' -e 's|reboot": false|reboot": true|' /etc/supergfxd.conf

sudo systemctl restart supergfxd.service

sudo sbctl create-keys
sudo sbctl enroll-keys --microsoft
sudo limine-enroll-config
sudo limine-update

rm -rf ~/dotfiles/
