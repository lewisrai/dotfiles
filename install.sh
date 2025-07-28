#!/usr/bin/env bash


packages=(
    '7zip'
    'asusctl'
    'biome'
    'blueman'
    'brightnessctl'
    'dunst'
    'fcitx5-im'
    'fcitx5-mozc'
    'gimp'
    'gvfs' 
    'hunspell-en_gb' 
    'hypridle'
    'hyprland'
    'hyprlock'
    'hyprpaper'
    'hyprpolkitagent'
    'imv'
    'jedi-language-server'
    'lazygit'
    'libreoffice-fresh'
    'librewolf'
    'mpv'
    'ncspot'
    'network-manager-applet'
    'nvim'
    'nwg-look'
    'obs-studio'
    'otf-firamono-nerd'
    'powertop'
    'proton-vpn-gtk-app'
    'rofi-wayland'
    'ruff'
    'sbctl' 
    'supergfxctl'
    'thunar' 
    'uwsm'
    'v4l2loopback-dkms'
    'vpl-gpu-rt'
    'waybar'
    'xdg-desktop-portal-hyprland'
)


mv .config/* ~/.config/
mv .git/ ~/
mv -f .bash_profile ~/
mv -f .bashrc ~/
mv .gitignore ~/

rm .bash_logout

mkdir -p ~/.local/share/fcitx5/themes/
git clone https://github.com/catppuccin/fcitx5
mv fcitx5/src/catppuccin-mocha-pink/ ~/.local/share/fcitx5/themes/
rm -rf fcitx5/

sudo pacman -Syu --needed --noconfirm

sudo sed -i -e 's/consolefont //' -e 's/plymouth //' /etc/mkinitcpio.conf
sudo sed -i -e 's/"quiet/"ipv6.disable=1 rcutree.enable_rcu_lazy=1 quiet/' -e 's/splash //' /etc/default/limine

sudo touch /etc/systemd/zram-generator.conf

sudo pacman -Rsn plymouth cachyos-plymouth-bootanimation --noconfirm

sudo pacman -S "${packages[@]}" --needed --noconfirm

paru -Syua
paru -Sa catppuccin-gtk-theme-mocha hyprshot rose-pine-hyprcursor --needed --noconfirm

asusctl -c 80
asusctl aura static -c b4befe
asusctl aura-power keyboard -a

powerprofilesctl configure-battery-aware --disable
powerprofilesctl set power-saver

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

sudo rm /etc/xdg/autostart/blueman.desktop

sudo sed -i -e 's/#AutoEnable=true/AutoEnable=false/' /etc/bluetooth/main.conf
sudo sed -i -e 's/Hybrid/Integrated/' -e 's/None/Asus/' -e 's/"always_reboot": false/"always_reboot": true/' /etc/supergfxd.conf

sudo systemctl enable --now powertop.service supergfxd
sudo systemctl --user --global enable hypridle.service hyprpolkitagent.service

sudo sed -i -e '1s/^/term_foreground_bright: cdd6f4\n/' /boot/limine.conf
sudo sed -i -e '1s/^/term_background_bright: 585b70\n/' /boot/limine.conf
sudo sed -i -e '1s/^/term_foreground: cdd6f4\n/' /boot/limine.conf
sudo sed -i -e '1s/^/term_background: 1e1e2e\n/' /boot/limine.conf
sudo sed -i -e '1s/^/term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4\n/' /boot/limine.conf
sudo sed -i -e '1s/^/term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4\n/' /boot/limine.conf

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
sudo sbctl enroll-keys -m
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
sudo limine-enroll-config

mv install.sh ~/
rm -rf ~/dotfiles/
