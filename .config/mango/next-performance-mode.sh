set_profile() {
    notify-send -h string:x-dunst-stack-tag:powerprofile "Power Plan: $1"
    powerprofilesctl set $1
}


case $(powerprofilesctl get) in
    'power-saver') set_profile 'balanced';;
    'balanced') set_profile 'performance';;
    'performance') set_profile 'power-saver';;
esac
