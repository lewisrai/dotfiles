if cat ~/.config/hypr/hyprland.conf | grep 2560x1600@60; then
    pkexec cpupower frequency-set --governor performance
    sed -i -e 's/2560x1600@60/2560x1600@165/' ~/.config/hypr/hyprland.conf
    hyprctl reload
    asusctl armoury panel_overdrive 1
    powerprofilesctl set performance
    notify-send -h string:x-dunst-stack-tag:gamemode "Game Mode: on"
else
    pkexec cpupower frequency-set --governor powersaver
    sed -i -e 's/2560x1600@165/2560x1600@60/' ~/.config/hypr/hyprland.conf
    hyprctl reload
    asusctl armoury panel_overdrive 0
    powerprofilesctl set power-saver
    notify-send -h string:x-dunst-stack-tag:gamemode "Game Mode: off"
fi
