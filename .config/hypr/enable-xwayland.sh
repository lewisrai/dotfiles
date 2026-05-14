if hyprctl getoption xwayland:enabled | grep 0; then
    sed -i -e 's|xwayland:enabled|#xwayland:enabled|' ~/.config/hypr/hyprland.conf
    hyprctl reload
    notify-send -h string:x-dunst-stack-tag:xwayland "xwayland: enabled"
fi
