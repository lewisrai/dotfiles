export HISTSIZE=100

export XCURSOR_SIZE=24

export HYPRCURSOR_SIZE=24
export HYPRCURSOR_THEME=catppuccin-mocha-dark-cursors

export ELECTRON_OZONE_PLATFORM_HINT=auto
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export WEBKIT_DISABLE_DMABUF_RENDERER=1

export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export QT_IM_MODULES='wayland;fcitx'

export PROTON_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland

sed -i -e 's|#xwayland:enabled|xwayland:enabled|' ~/.config/hypr/hyprland.conf

if [[ "$(tty)" == "/dev/tty1" ]]; then
    hyprland > /dev/null
fi
