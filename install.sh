packages=(
    '7zip'
    'asusctl'
    'biome'
    'blueman'
    'brightnessctl'
    'dunst'
    'fcitx5-im'
    'fcitx5-mozc'
    'gparted'
    'gimp'
    'gvfs' 
    'hunspell-en_gb' 
    'hypridle'
    'hyprland'
    'hyprlock'
    'hyprpaper'
    'hyprpolkitagent'
    'hyprshot'
    'imv'
    'intellij-idea-community-edition'
    'jedi-language-server'
    'lazygit'
    'libreoffice-fresh'
    'lua-language-server'
    'lutris'
    'mpv'
    'network-manager-applet'
    'nvim'
    'nwg-look'
    'obs-studio'
    'obsidian'
    'otf-firamono-nerd'
    'powertop'
    'proton-cachyos'
    'proton-vpn-gtk-app'
    'qbittorrent'
    'qgis'
    'rhythmbox'
    'rofi'
    'ruff'
    'sbctl' 
    'shotcut'
    'steam'
    'supergfxctl'
    'thunar' 
    'vpl-gpu-rt'
    'waybar'
    'xdg-desktop-portal-hyprland'
)

aur=(
    'catppuccin-cursors-mocha'
    'catppuccin-fcitx5-git'
    'catppuccin-gtk-theme-mocha'
    'catppuccin-qt5ct-git'
    'helium-browser-bin'
    'hyprqt6engine'
    'neo4j-desktop'
    'vesktop-bin'
)

mv -f .config/* ~/.config/
mv -f .local/share/* ~/.local/share/
mv -f *. ~/

rm -f .bash_logout

sudo mkdir -p /usr/local/share/kbd/keymaps/
sudo cp /usr/share/kbd/keymaps/i386/qwerty/uk.map.gz /usr/local/share/kbd/keymaps/uk-custom.map.gz
sudo sed -i -e 's|Caps_Lock|Escape|' /usr/local/share/kbd/keymaps/uk-custom.map.gz
sudo sed -i -e 's|uk|/usr/local/share/kbd/keymaps/uk-custom.map.gz|' /etc/vconsole.conf

sudo sed -i -e 's|#Storage=auto|Storage=none|' /etc/systemd/journald.conf
sudo journalctl --rotate
sudo journalctl --vacuum-time=1s
sudo systemctl restart systemd-journald
rm -R /run/log/journal/*
sudo rm -R /var/log/journal/*

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

sudo sed -i -e 's|consolefont ||' -e 's|plymouth ||' /etc/mkinitcpio.conf
sudo sed -i -e 's|"quiet|"i915.force_probe=!46a6 xe.force_probe=46a6 ipv6.disable=1 pcie_aspm=force rcutree.enable_rcu_lazy=1 split_lock_detect=off systemd.zram=0 quiet loglevel=5|' -e 's|splash ||' /etc/default/limine

sudo pacman -Rsn cachyos-plymouth-bootanimation plymouth switcheroo-control --noconfirm

sudo pacman -Syu "${packages[@]}" --needed --noconfirm

paru -Syua "${aur[@]}" --needed

asusctl -c 80
asusctl aura static -c f5c2e7
asusctl aura-power keyboard -a

cat << 'EOF' | sudo tee -i /etc/modprobe.d/alsa-base.conf
options snd-hda-intel model=1043:1f11
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

cat << 'EOF' | sudo tee -i /etc/systemd/system/panel-overdrive.service
[Unit]
Description=Disable panel overdrive
After=asusd.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/asusctl armoury panel_overdrive 0

[Install]
WantedBy=multi-user.target
EOF

cat << 'EOF' | sudo tee -i /etc/systemd/system/powersaver.service
[Unit]
Description=Powersaver
After=multi-user.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/powerprofilesctl set power-saver

[Install]
WantedBy=multi-user.target
EOF

cat << 'EOF' | sudo tee -i /etc/systemd/system/powertop.service
[Unit]
Description=Powertop tunings

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/powertop --auto-tune

[Install]
WantedBy=multi-user.target
EOF

sudo sed -i -e 's|#AutoEnable=true|AutoEnable=false|' /etc/bluetooth/main.conf
sudo sed -i -e 's|Hybrid|Integrated|' -e 's|None|Asus|' -e 's|reboot": false|reboot": true|' /etc/supergfxd.conf
sudo sed -i -e 's|#DNS=|DNS=1.1.1.1 1.0.0.1|' /etc/systemd/resolved.conf

sudo systemctl enable no-turbo.service panel-overdrive.service powersaver.service powertop.service supergfxd.service
sudo systemctl --user --global enable hypridle.service hyprpolkitagent.service

cat << 'EOF' | sudo tee -i /etc/issue
\e]P01E1E2E\e]P2A6E3A1\e]PFCDD6F4\e[2J\e[H
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

sudo sbctl create-keys
sudo sbctl enroll-keys --microsoft
sudo limine-enroll-config

mv install.sh ~/
rm -rf ~/dotfiles/
