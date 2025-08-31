no='cancel'

if cat ~/.config/hypr/hyprland.conf | grep 'xwayland:enabled = true'; then
    yes='disable xwayland' 

    if [ "$(echo -e "$no\n$yes" | rofi -dmenu -theme ~/.config/rofi/menu.rasi)" == "$yes" ]; then
        hyprctl dispatch exit && sed -i -e 's|xwayland:enabled = true|xwayland:enabled = false|' ~/.config/hypr/hyprland.conf;;
    fi
else
    yes='enable xwayland' 

    if [ "$(echo -e "$no\n$yes" | rofi -dmenu -theme ~/.config/rofi/menu.rasi)" == "$yes" ]; then
        hyprctl dispatch exit && sed -i -e 's|xwayland:enabled = false|xwayland:enabled = true|' ~/.config/hypr/hyprland.conf;;
    fi 
fi
