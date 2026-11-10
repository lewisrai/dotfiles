import QtQuick
import QtQuick.Layouts
import Quickshell.Io

import "./Common/"

RowLayout {
    id: tag

    property int activeTag: 0

    spacing: 14

    Process {
        command: ["mmsg", "watch", "tags", "eDP-1"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                tag.activeTag = JSON.parse(data).tags.find(t => t.is_active).index - 1;
            }
        }
    }

    Repeater {
        model: 9

        StyledText {
            font.pixelSize: 20
            text: index === tag.activeTag ? "" : ""
        }
    }
}
