xwayland='xwayland'
integrated='integrated'
nvidia='nvidia'

case $(echo -e "$xwayland\n$integrated\n$nvidia" | rofi -dmenu -theme ~/.config/rofi/menu.rasi) in
    $xwayland)
        sed -i -e 's|xwayland:enabled = false|xwayland:enabled = true|' ~/.config/hypr/hyprland.conf
        hyprctl reload;;
    $integrated)
        pkexec sh -c 'sed -i -e "s/AsusMuxDgpu/Integrated/" /etc/supergfxd.conf; systemctl restart supergfxd'
        echo -e 'supergfxctl -m Integrated' >> reboot.sh
        chmod +x reboot.sh;;
    $nvidia)
        pkexec sh -c 'sed -i -e "s/Integrated/AsusMuxDgpu/" /etc/supergfxd.conf; systemctl restart supergfxd'
        echo -e 'supergfxctl -m AsusMuxDgpu' >> reboot.sh
        chmod +x reboot.sh;;
esac
