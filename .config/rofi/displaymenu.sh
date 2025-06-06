#!/usr/bin/env bash


low='60 Hz'
high='165 Hz'

chosen="$(echo -e "$low\n$high" | rofi -dmenu -theme ~/.config/rofi/menu.rasi)"

case ${chosen} in
    $low) asusctl armoury panel_overdrive 0 && sed -i -e 's/2560x1600@165/2560x1600@60/' ~/.config/hypr/hyprland.conf;;
    $high) asusctl armoury panel_overdrive 1 && sed -i -e 's/2560x1600@60/2560x1600@165/' ~/.config/hypr/hyprland.conf;;
esac
