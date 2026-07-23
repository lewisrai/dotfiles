export HISTSIZE=100

export ELECTRON_OZONE_PLATFORM_HINT=auto
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct

export QT_IM_MODULE=fcitx
export QT_IM_MODULES='wayland;fcitx'

sed -i -e 's|refresh:165|refresh:60|' ~/.config/mango/config.conf

if [[ "$(tty)" == "/dev/tty1" ]]; then
    mango > /dev/null
fi
