if grep refresh:60 ~/.config/mango/config.conf; then
    pkexec sh -c 'cpupower frequency-set --governor performance; cpupower frequency-set --min 2500MHz; scxctl switch --sched lavd --mode gaming'
    sed -i -e 's|refresh:60|refresh:165|' ~/.config/mango/config.conf
    mmsg dispatch reload_config
    asusctl armoury set panel_overdrive 1
    powerprofilesctl set performance
    notify-send -h string:tag:gamemode "Game Mode: on"
else
    pkexec sh -c 'cpupower frequency-set --governor powersaver; cpupower frequency-set --min 400MHz; scxctl switch --sched lavd --mode powersave'
    sed -i -e 's|refresh:165|refresh:60|' ~/.config/mango/config.conf
    mmsg dispatch reload_config
    asusctl armoury set panel_overdrive 0
    powerprofilesctl set power-saver
    notify-send -h string:tag:gamemode "Game Mode: off"
fi
