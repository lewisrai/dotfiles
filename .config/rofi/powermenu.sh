#!/usr/bin/env bash


lock=''
suspend=''
logout='󰍃'
reboot=''
shutdown='󰐥'

chosen="$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu -theme ~/.config/rofi/menu.rasi)"

case ${chosen} in
    $lock) loginctl lock-session;;
    $suspend) systemctl suspend;;
    $logout) hyprctl dispatch exit;;
    $reboot) systemctl reboot;;
    $shutdown) systemctl poweroff;;
esac
