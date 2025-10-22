xwayland='xwayland'
vrr='vrr'
igpu='iGPU'
dgpu='dGPU'

case $(echo -e "$xwayland\n$vrr\n$igpu\n$dgpu" | rofi -dmenu -theme ~/.config/rofi/menu.rasi) in
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
    $igpu)
        notify-send 'Mux: setting iGPU...'
        touch ~/reboot
        supergfxctl -m Integrated
        sleep 15
        notify-send 'Mux: iGPU';;
    $dgpu)
        notify-send 'Mux: setting dGPU...'
        supergfxctl -m Hybrid
        sleep 15
        supergfxctl -m AsusMuxDgpu
        sleep 15
        notify-send 'Mux: dGPU';;
esac
