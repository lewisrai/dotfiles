if [ -f reboot.sh ]; then
    ./reboot.sh
    rm -f reboot.sh
    systemctl reboot
fi

alias hyprland='pidof hyprland || hyprland'

export PROTON_ENABLE_WAYLAND=1
export PROTON_NO_STEAMINPUT=1
export QT_QPA_PLATFORMTHEME=qt6ct
export UMU_RUNTIME_UPDATE=0

sed -i -e 's/2560x1600@165/2560x1600@60/' -e 's|xwayland:enabled = true|xwayland:enabled = false|' ~/.config/hypr/hyprland.conf

if [[ "$(tty)" == "/dev/tty1" ]]; then
    hyprland > /dev/null
fi
