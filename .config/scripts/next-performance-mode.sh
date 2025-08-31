next_profile() {
    powerprofilesctl set $1
    notify-send -h string:x-dunst-stack-tag:powerprofile "Power Plan: $1"
}

case $(powerprofilesctl get) in
    power-saver) next_profile "balanced";;
    balanced) next_profile "performance";;
    performance) next_profile "power-saver";;
esac
