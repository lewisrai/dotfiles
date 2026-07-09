if hyprctl monitors | head -2 | grep 2560x1600@60; then
    pkexec sh -c 'cpupower frequency-set --governor performance; cpupower frequency-set --min 2500MHz; scxctl switch --sched lavd --mode gaming'
    hyprctl dispatch 'hl.monitor({ output = "desc:BOE 0x0A0B", mode = "2560x1600@165", position = "0x0", scale = "1" })'
    hyprctl keyword monitor 'desc:BOE 0x0A0B, 2560x1600@165, 0x0, 1'
    asusctl armoury set panel_overdrive 1
    powerprofilesctl set performance
    notify-send -h string:x-dunst-stack-tag:gamemode "Game Mode: on"
else
    pkexec sh -c 'cpupower frequency-set --governor powersaver; cpupower frequency-set --min 400MHz; scxctl switch --sched lavd --mode powersave'
    hyprctl dispatch 'hl.monitor({ output = "desc:BOE 0x0A0B", mode = "2560x1600@60", position = "0x0", scale = "1" })'
    asusctl armoury set panel_overdrive 0
    powerprofilesctl set power-saver
    notify-send -h string:x-dunst-stack-tag:gamemode "Game Mode: off"
fi
