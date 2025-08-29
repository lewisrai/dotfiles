if cat ~/.config/hypr/hyprland.conf | grep 'xwayland:enabled = true'; then
    no='cancel'
    yes='disable xwayland' 

    case $(echo -e "$no\n$yes" | rofi -dmenu -theme ~/.config/rofi/menu.rasi) in
        $no) ;;
        $yes) sed -i -e 's|xwayland:enabled = true|xwayland:enabled = false|' ~/.config/hypr/hyprland.conf && hyprctl dispatch exit && hyprland;;
    esac
else
    no='cancel'
    yes='enable xwayland' 

    case $(echo -e "$no\n$yes" | rofi -dmenu -theme ~/.config/rofi/menu.rasi) in
        $no) ;;
        $yes) sed -i -e 's|xwayland:enabled = false|xwayland:enabled = true|' ~/.config/hypr/hyprland.conf && hyprctl dispatch exit && hyprland;;
    esac
fi
