import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "./Common/"

FloatingWindow {
    id: root
    title: "launcher"

    visible: false
    implicitWidth: 400
    implicitHeight: 220

    property var items: []
    property var filtered: []
    property var selected: 0

    function open() {
        visible = true
        get.running = true
    }

    function changed() {
        root.filtered = root.items.filter(item => item.includes(input.text)).slice(0, 7)
        root.selected = root.selected < root.filtered.length ? root.selected : root.filtered.length - 1
    }

    Process {
        id: get
        command: ["ls", "/usr/bin"]
        running: false

        stdout: SplitParser {
            onRead: data => {
                items.push(data)
            }
        }
    }

    Process {
        id: runner
    }

    color: "#1e1e2e"

    ColumnLayout {
        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Return && filtered.length > 0) {
                runner.command = filtered[selected]
                runner.startDetached()
                root.visible = false
                items.length = 0
                selected = 0
                input.text = ""
            } else if (event.key === Qt.Key_Escape) {
                root.visible = false
                selected = 0
                items.length = 0
                input.text = ""
            } else if (event.key === Qt.Key_Up) {
                selected = selected == 0 ? 0 : selected - 1
            } else if (event.key === Qt.Key_Down) {
                selected = selected == filtered.length - 1 ? selected : selected + 1
            }
        }
        anchors.fill: parent
        anchors.margins: 12
        spacing: 0

        TextField {
            id: input
            Layout.fillWidth: true
            focus: true
            onTextChanged: root.changed()
        }

        ListView {
            width: parent.width
            height: parent.height
            model: filtered

            delegate: Rectangle {
                width: parent.width
                height: 24
                color: "#1e1e2e"

                StyledText {
                    anchors.verticalCenter: parent.verticalCenter
                    color: index == selected ? "#f9e2af" : "#f5c2e7"
                    text: modelData
                    leftPadding: 4
                }
            }
        }
    }
}
