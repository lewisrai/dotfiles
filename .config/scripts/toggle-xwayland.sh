
if cat ~/.config/hypr/hyprland.conf | grep 'xwayland:enabled = true'; then
    no='cancel'
    yes='disable xwayland' 

    if [ "$(echo -e "$no\n$yes" | rofi -dmenu -theme ~/.config/rofi/menu.rasi)" == "$yes" ]; then
        hyprctl dispatch exit
        pid=$(pidof hyprland)
        wait $pid
        sed -i -e 's|xwayland:enabled = true|xwayland:enabled = false|' ~/.config/hypr/hyprland.conf
        hyprland
    fi
else
    no='cancel'
    yes='enable xwayland' 

    if [ "$(echo -e "$no\n$yes" | rofi -dmenu -theme ~/.config/rofi/menu.rasi)" == "$yes" ]; then
        hyprctl dispatch exit
        pid=$(pidof hyprland)
        wait $pid
        sed -i -e 's|xwayland:enabled = false|xwayland:enabled = true|' ~/.config/hypr/hyprland.conf
        hyprland
    fi 
fi
