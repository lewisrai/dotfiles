if hyprctl getoption xwayland.enabled | grep false; then
    sed -i -e 's|xwayland = 0|xwayland = 1|' ~/.config/hypr/hyprland.lua
    hyprctl reload
    notify-send -h string:x-dunst-stack-tag:xwayland "xwayland: enabled"
fi
