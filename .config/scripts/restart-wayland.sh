hyprctl dispatch exit
while [ $(pidof hyprland) ]; do
    sleep 1
done
clear
hyprland > /dev/null
