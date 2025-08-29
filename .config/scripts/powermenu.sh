#!/usr/bin/env bash


lock=''
suspend=''
logout='󰍃'
reboot=''
shutdown='󰐥'

case $(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu -theme ~/.config/rofi/menu.rasi) in
    $lock) loginctl lock-session;;
    $suspend) systemctl suspend;;
    $logout) loginctl terminate-session '';;
    $reboot) systemctl reboot;;
    $shutdown) systemctl poweroff;;
esac
