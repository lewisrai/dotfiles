export HISTSIZE=100
export QT_QPA_PLATFORMTHEME=hyprqt6engine

sed -i -e 's/2560x1600@165/2560x1600@60/' -e 's|xwayland:enabled = true|xwayland:enabled = false|' -e 's|misc:vrr = 0|misc:vrr = 1|' ~/.config/hypr/hyprland.conf

if [[ "$(tty)" == "/dev/tty1" ]]; then
    hyprland > /dev/null
fi
