import Quickshell.Io

import "./Common/"

StyledText {
    id: brightness

    property int max: 1

    FileView {
        path: "/sys/class/backlight/intel_backlight/brightness"
        watchChanges: true

        onFileChanged: update.running = true
    }

    Process {
        id: update

        command: ["brightnessctl", "get"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const level = Math.round(Number(data) * 100 / brightness.max);

                if (level < 10)
                    text = `󰃞 ~${level}%`;
                else if (level < 34)
                    text = `󰃞 ${level}%`;
                else if (level < 67)
                    text = `󰃟 ${level}%`;
                else if (level < 100)
                    text = `󰃠 ${level}%`;
                else
                    text = `󰃠 ~C%`;
            }
        }
    }

    Process {
        command: ["brightnessctl", "max"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                brightness.max = Number(data);
            }
        }
    }
}
