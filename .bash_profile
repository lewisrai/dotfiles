export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_DOWNLOAD_DIR="$HOME/download"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pictures"
export XDG_PROJECTS_DIR="$HOME/projects"
export XDG_PUBLICSHARE_DIR="$HOME/public"
export XDG_TEMPLATES_DIR="$HOME/templates"
export XDG_VIDEOS_DIR="$HOME/videos"

export HISTSIZE=99

export ELECTRON_OZONE_PLATFORM_HINT=auto
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct

sed -i -e 's|refresh:165|refresh:60|' ~/.config/mango/config.conf

if [[ "$(tty)" == "/dev/tty1" ]]; then
    mango > /dev/null
fi
