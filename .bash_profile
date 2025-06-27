if uwsm check may-start; then 
    asusctl armoury panel_overdrive 0
    powerprofilesctl set power-saver
    exec uwsm start hyprland.desktop
fi
