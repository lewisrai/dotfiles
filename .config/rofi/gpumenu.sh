#!/usr/bin/env bash


integrated=' Integrated'
nvidia=' Nvidia'

chosen="$(printf "$integrated\n$nvidia" | rofi -dmenu -theme ~/.config/rofi/menu.rasi)"

case ${chosen} in
    $integrated) pkexec sed -i -e 's/AsusMuxDgpu/Integrated/' /etc/supergfxd.conf && systemctl restart supergfxd && systemctl poweroff;;
    $nvidia) pkexec sed -i -e 's/Integrated/AsusMuxDgpu/' /etc/supergfxd.conf && systemctl restart supergfxd && systemctl poweroff;;
esac
