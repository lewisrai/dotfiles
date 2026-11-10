import Quickshell.Io

import "./Common/"

StyledText {
    readonly property int maxBrightness: Number(max.text().trim())

    text: {
        const level = Math.round(Number(brightness.text().trim()) * 100 / this.maxBrightness);

        return level < 10 ? "󰃞 ~" + level + "%" : level < 33 ? "󰃞 " + level + "%" : level < 66 ? "󰃟 " + level + "%" : level < 100 ? "󰃠 " + level + "%" : "󰃠 ~C%";
    }

    FileView {
        id: brightness

        watchChanges: true

        onFileChanged: this.reload()
    }

    FileView {
        id: max
    }

    Process {
        id: path

        property bool set: false

        command: ["ls", "/sys/class/backlight/"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                if (path.set) {
                    return;
                }

                path.set = true;

                brightness.path = "/sys/class/backlight/" + data + "/brightness";
                max.path = "/sys/class/backlight/" + data + "/max_brightness";
            }
        }
    }
}
