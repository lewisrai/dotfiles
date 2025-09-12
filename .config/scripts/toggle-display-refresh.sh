if cat ~/.config/hypr/hyprland.conf | grep 2560x1600@60; then
    asusctl armoury panel_overdrive 1
    sed -i -e 's/2560x1600@60/2560x1600@165/' ~/.config/hypr/hyprland.conf
    powerprofilesctl set performance
    notify-send 'Performance Mode'
else
    asusctl armoury panel_overdrive 0
    sed -i -e 's/2560x1600@165/2560x1600@60/' ~/.config/hypr/hyprland.conf
    powerprofilesctl set power-saver
    notify-send 'Power Saving Mode'
fi
