#!/usr/bin/env bash


silent='󰠝 Silent'
balanced='󱜝 Balanced'
turbo='󱪂 Turbo'

chosen="$(printf "$silent\n$balanced\n$turbo" | rofi -dmenu -theme ~/.config/rofi/menu.rasi)"

case ${chosen} in
    $silent) powerprofilesctl set power-saver;;
    $balanced) powerprofilesctl set balanced;;
    $turbo) powerprofilesctl set performance;;
esac
