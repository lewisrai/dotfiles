no='cancel'

if cat ~/.config/hypr/hyprland.conf | grep 'xwayland:enabled = true'; then
    yes='disable xwayland' 

    if [ "$(echo -e "$no\n$yes" | rofi -dmenu -theme ~/.config/rofi/menu.rasi)" == "$yes" ]; then
        hyprctl dispatch exit

        while [ $(pidof hyprland) ]; do
            sleep 1
        done

        clear
        sed -i -e 's|xwayland:enabled = true|xwayland:enabled = false|' ~/.config/hypr/hyprland.conf
        hyprland > /dev/null
    fi
else
    yes='enable xwayland' 

    if [ "$(echo -e "$no\n$yes" | rofi -dmenu -theme ~/.config/rofi/menu.rasi)" == "$yes" ]; then
        hyprctl dispatch exit

        while [ $(pidof hyprland) ]; do
            sleep 1
        done

        clear
        sed -i -e 's|xwayland:enabled = false|xwayland:enabled = true|' ~/.config/hypr/hyprland.conf
        hyprland > /dev/null
    fi 
fi
