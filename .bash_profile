unset HISTFILE

export ELECTRON_OZONE_PLATFORM_HINT=auto
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct

sed -i -e 's|refresh:165|refresh:60|' ~/.config/mango/config.conf

if [[ "$(tty)" == "/dev/tty1" ]]; then
    mango > /dev/null
fi
