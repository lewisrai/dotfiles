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

export BEMENU_OPTS='--fn "FiraMonoNerdFont 14" --tb "#1e1e2e" --tf "#f5c2e7" --fb "#1e1e2e" --ff "#cdd6f4" --nb "#1e1e2e" --nf "#cdd6f4" --hb "#1e1e2e" --hf "#f9e2af" --ab "#1e1e2e" --af "#cdd6f4" --bdr "#f5c2e7"'

export PROTON_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland

sed -i -e 's|#xwayland:enabled|xwayland:enabled|' ~/.config/hypr/hyprland.conf

if [[ "$(tty)" == "/dev/tty1" ]]; then
    hyprland > /dev/null
fi
