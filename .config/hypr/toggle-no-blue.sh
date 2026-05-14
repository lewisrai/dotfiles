if hyprctl getoption decoration:screen_shader | grep glsl; then
    notify-send -h string:x-dunst-stack-tag:blue 'no blue: disabled'
    hyprctl keyword decoration:screen_shader ''
    asusctl aura effect static --colour f5c2e7
else
    notify-send -h string:x-dunst-stack-tag:blue 'no blue: enabled'
    hyprctl keyword decoration:screen_shader ~/.config/hypr/no-blue.glsl
    asusctl aura effect static --colour ffff00
fi
