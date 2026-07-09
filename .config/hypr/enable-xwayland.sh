if hyprctl getoption xwayland.enabled | grep false; then
    sed -i -e 's|identifier = 0|identifier = 1|' ~/.config/hypr/hyprland.lua
    hyprctl reload
    notify-send -h string:x-dunst-stack-tag:xwayland "xwayland: enabled"
fi
