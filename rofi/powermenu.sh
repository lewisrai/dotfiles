#!/usr/bin/env bash


lock=''
suspend=''
logout='󰍃'
reboot=''
shutdown='⏻'

rofi_cmd() {
    rofi -dmenu -theme ~/.config/rofi/powermenu.rasi
}

run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

chosen="$(run_rofi)"

case ${chosen} in
    $lock) loginctl lock-session;;
    $suspend) systemctl suspend;;
    $logout) hyprctl dispatch exit;;
    $reboot) systemctl reboot;;
    $shutdown) systemctl poweroff;;
esac
