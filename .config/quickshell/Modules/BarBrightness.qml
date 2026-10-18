import Quickshell.Io

import "./Common/"

StyledText {
    FileView {
        id: brightness

        watchChanges: true

        onFileChanged: this.reload()
    }

    FileView {
        id: max

        watchChanges: false
    }

    Process {
        id: path

        property bool set: false

        command: ["ls", "/sys/class/backlight/"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                if (path.set) {
                    return
                }

                path.set = true

                brightness.path = "/sys/class/backlight/" + data + "/brightness"
                max.path = "/sys/class/backlight/" + data + "/max_brightness"
            }
        }
    }

    text: {
        const level = Math.round(Number(brightness.text().trim()) * 100 / Number(max.text().trim()));

        if (level < 10)
            return `󰃞 ~${level}%`;
        else if (level < 34)
            return `󰃞 ${level}%`;
        else if (level < 67)
            return `󰃟 ${level}%`;
        else if (level < 100)
            return `󰃠 ${level}%`;
        else
            return `󰃠 ~C%`;
    }
}
