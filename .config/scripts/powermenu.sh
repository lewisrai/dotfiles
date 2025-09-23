lock=''
suspend=''
logout='󰍃'
reboot=''
session='󰿄'
firmware=''
shutdown='󰐥'

case $(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu -theme ~/.config/rofi/menu.rasi) in
    $lock) loginctl lock-session;;
    $suspend) systemctl suspend;;
    $logout) loginctl terminate-session '';;
    $reboot)
        case $(echo -e "$reboot\n$session\n$firmware" | rofi -dmenu -theme ~/.config/rofi/menu.rasi) in
            $reboot) systemctl reboot;;
            $session)
                hyprctl dispatch exit
                while [ $(pidof hyprland) ]; do
                    sleep 1
                done
                clear
                sed -i -e 's/2560x1600@165/2560x1600@60/' -e 's|xwayland:enabled = true|xwayland:enabled = false|' ~/.config/hypr/hyprland.conf
                hyprland > /dev/null;;
            $firmware) systemctl reboot --firmware-setup;;
        esac;;
    $shutdown) systemctl poweroff;;
esac
