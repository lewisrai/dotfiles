xwayland='xwayland'
vrr='vrr'
integrated='integrated'
nvidia='nvidia'

case $(echo -e "$xwayland\n$vrr\n$integrated\n$nvidia" | rofi -dmenu -theme ~/.config/rofi/menu.rasi) in
    $xwayland)
        if cat ~/.config/hypr/hyprland.conf | grep 'xwayland:enabled = false'; then
            sed -i -e 's|xwayland:enabled = false|xwayland:enabled = true|' ~/.config/hypr/hyprland.conf
            hyprctl reload
        else
            sed -i -e 's|xwayland:enabled = false|xwayland:enabled = true|' ~/.config/hypr/hyprland.conf
            ~/.config/scripts/restart-wayland.sh
        fi;;
    $vrr)
        if cat ~/.config/hypr/hyprland.conf | grep 'misc:vrr = 1'; then
            sed -i -e 's|misc:vrr = 1|misc:vrr = 0|' ~/.config/hypr/hyprland.conf
            ~/.config/scripts/restart-wayland.sh
        else
            sed -i -e 's|misc:vrr = 0|misc:vrr = 1|' ~/.config/hypr/hyprland.conf
            hyprctl reload
        fi;;
    $integrated)
        pkexec sh -c 'sed -i -e "s/AsusMuxDgpu/Integrated/" /etc/supergfxd.conf; systemctl restart supergfxd'
        echo -e 'supergfxctl -m Integrated' >> reboot.sh
        chmod +x reboot.sh;;
    $nvidia)
        pkexec sh -c 'sed -i -e "s/Integrated/AsusMuxDgpu/" /etc/supergfxd.conf; systemctl restart supergfxd'
        echo -e 'supergfxctl -m AsusMuxDgpu' >> reboot.sh
        chmod +x reboot.sh;;
esac
