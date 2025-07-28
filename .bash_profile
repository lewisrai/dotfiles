if [ -f reboot.sh ]; then
    ./reboot.sh
    rm -f reboot.sh
    systemctl reboot
fi

if uwsm check may-start; then 
    asusctl armoury panel_overdrive 0 > /dev/null
    powerprofilesctl set power-saver > /dev/null
    exec uwsm start hyprland.desktop > /dev/null
fi
