import QtQuick
import Quickshell.Io

Text {
    id: brightness

    readonly property string backlight: "/sys/class/backlight/intel_backlight/brightness"
    property int level: 0
    property int max: 1
    property string icon: "󰃞"

    FileView {
        id: currentBrightness

        path: brightness.backlight

        watchChanges: true
        onFileChanged: getBrightness.running = true
    }

    Process {
        id: getBrightness

        command: ["brightnessctl", "get"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                brightness.level = Number(data) * 100 / brightness.max

                if (brightness.level >= 66) brightness.icon = "󰃠"
                else if (brightness.level >= 33) brightness.icon = "󰃟"
                else brightness.icon = "󰃞"
            }
        }
    }

    Process {
        command: ["brightnessctl", "max"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                brightness.max = Number(data)
            }
        }
    }

    text: `${brightness.icon}  ${brightness.level}%`
}
