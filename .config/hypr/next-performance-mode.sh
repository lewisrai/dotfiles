case $(powerprofilesctl get) in
    power-saver) powerprofilesctl set balanced && notify-send 'Power Plan set to Balanced';;
    balanced) powerprofilesctl set performance && notify-send 'Power Plan set to Performance';;
    performance) powerprofilesctl set power-saver && notify-send 'Power Plan set to Power-Saver';;
esac
