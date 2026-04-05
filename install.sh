packages=(
    '7zip'
    'asusctl'
    'audacious'
    'bemenu'
    'bemenu-wayland'
    'biome'
    'blueman'
    'brightnessctl'
    'cups'
    'dunst'
    'easyeffects'
    'foot'
    'fcitx5-im'
    'fcitx5-mozc'
    'gparted'
    'gimp'
    'gvfs'
    'gvfs-mtp'
    'helium-browser-bin'
    'hplip'
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
    'lutris'
    'mimalloc'
    'mpv'
    'network-manager-applet'
    'nvim'
    'nwg-look'
    'obs-studio'
    'obsidian'
    'ollama'
    'opencode'
    'otf-firamono-nerd'
    'prismlauncher'
    'proton-cachyos-slr'
    'proton-vpn-gtk-app'
    'pwvucontrol'
    'python-argon2-cffi'
    'python-email-validator'
    'python-fastapi'
    'python-jose'
    'python-openai'
    'python-pygame'
    'python-pytest-asyncio'
    'python-python-multipart'
    'python-pytorch-opt'
    'python-scikit-learn'
    'python-sniffio'
    'python-sqlalchemy'
    'python-transformers'
    'python-tzdata'
    'qbittorrent'
    'qt6ct'
    'rust'
    'rust-analyzer'
    'scx-scheds'
    'scx-tools'
    'steam'
    'supergfxctl'
    'thunar' 
    'tree-sitter-bash'
    'tree-sitter-cli'
    'tree-sitter-javascript'
    'tree-sitter-python'
    'tree-sitter-rust'
    'ty'
    'uvicorn'
    'vesktop-bin'
    'waybar'
    'xdg-desktop-portal-hyprland'
)

aur=(
    'osu-lazer-bin'
    'pince-bin'
    'soteria-bin'
    'soundux'
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
timeout: 3
default_entry: 2
EOF

sudo sed -i -e 's|base ||' -e 's|udev|systemd|' -e 's|consolefont ||' -e 's|plymouth ||' /etc/mkinitcpio.conf
sudo sed -i -e 's|"quiet|"vt.default_red=30,243,166,249,137,203,137,205,30,243,166,249,137,203,137,205 vt.default_grn=30,139,227,226,180,166,220,214,30,139,227,226,180,166,220,214 vt.default_blu=46,168,161,175,250,247,235,244,46,168,161,175,250,247,235,244 vt.cur_default=0x641517 i915.force_probe=!46a6 xe.force_probe=46a6 ipv6.disable=1 pcie_aspm=force rcutree.enable_rcu_lazy=1 split_lock_detect=off systemd.zram=0 quiet loglevel=5|' -e 's|splash ||' /etc/default/limine

sudo pacman -Rsn cachyos-plymouth-bootanimation pavucontrol plymouth switcheroo-control --noconfirm

sudo pacman -Syu "${packages[@]}" --needed --noconfirm

paru -Syua "${aur[@]}" --needed

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
Description=No turbo boost

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash -c "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"

[Install]
WantedBy=multi-user.target
EOF

cat << 'EOF' | sudo tee -i /etc/systemd/system/powertop.service

[Unit]
Description=Powertop tunings

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash -c 'echo auto | tee /sys/bus/usb/devices/3-9/power/control /sys/bus/pci/devices/0000:00:0a.0/power/control /sys/bus/pci/devices/0000:00:00.0/power/control /sys/bus/pci/devices/0000:02:00.0/power/control /sys/bus/pci/devices/0000:03:00.0/power/control'

[Install]
WantedBy=multi-user.target
EOF

sudo sed -i -e 's|#AutoEnable=true|AutoEnable=false|' /etc/bluetooth/main.conf
sudo sed -i -e 's|Hybrid|Integrated|' -e 's|None|Asus|' -e 's|reboot": false|reboot": true|' /etc/supergfxd.conf

sudo systemctl enable no-turbo.service powertop.service scx_loader.service supergfxd.service
sudo systemctl --user --global enable hypridle.service

cat << 'EOF' | sudo tee -i /etc/issue
            :h-                                  Nhy`
           -mh.                           h.    `Ndho
           hmh+                          oNm.   oNdhh
          `Nmhd`                        /NNmd  /NNhhd
          -NNhhy                      `hMNmmm`+NNdhhh
          .NNmhhs              ```....`..-:/./mNdhhh+
           mNNdhhh-     `.-::///+++////++//:--.`-/sd`
           oNNNdhhdo..://++//++++++/+++//++///++/-.`
      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:
 .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+
 h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`
 hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`         \e[32mDate: \e[37m\d
 /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.        \e[32mTime: \e[37m\t
  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.       \e[32mSystem: \e[37m\s
   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.      \e[32mArch: \e[37m\m
     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`     \e[32mHost: \e[37m\n
       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:     \e[32mDomain: \e[37m\o
       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`    \e[32mRelease: \e[37m\r
       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:    \e[32mVersion: \e[37m\v
       //+++//++++++////+++///::--                 .::::-------::    \e[32mLogged in: \e[37m\U
       :/++++///////////++++//////.                -:/:----::../-    \e[32mTerminal: \e[37m\l
       -/++++//++///+//////////////               .::::---:::-.+`    \e[32mBaud rate: \e[37m\b
       `////////////////////////////:.            --::-----...-/
        -///://////////////////////::::-..      :-:-:-..-::.`.+`
         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -
           ::::://::://::::::::::::::----------..-:....`.../- -+oo/
            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``
           s-`::--:::------:////----:---.-:::...-.....`./:
          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`
         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-
        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`
                        .-:mNdhh:.......--::::-`
                           yNh/..------..`
 
EOF

mv install.sh ~/
rm -rf ~/dotfiles/
