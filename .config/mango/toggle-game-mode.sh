if grep refresh:60 ~/.config/mango/config.conf; then
    sed -i -e 's|refresh:60|refresh:165|' ~/.config/mango/config.conf
    mmsg dispatch reload_config
    asusctl armoury set panel_overdrive 1
    powerprofilesctl set performance
    notify-send -h string:tag:gamemode "Game Mode: on"
else
    sed -i -e 's|refresh:165|refresh:60|' ~/.config/mango/config.conf
    mmsg dispatch reload_config
    asusctl armoury set panel_overdrive 0
    powerprofilesctl set power-saver
    notify-send -h string:tag:gamemode "Game Mode: off"
fi
