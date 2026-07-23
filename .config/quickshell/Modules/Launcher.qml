import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

FloatingWindow {
    id: root
    title: "launcher"

    visible: false
    width: 400
    height: 220
    color: "transparent"

    property var items: []
    property var filtered: []

    function open() {
        visible = true
        get.running = true
    }

    function changed() {
        root.filtered = root.items.filter(item => item.includes(input.text)).slice(0, 3)
        console.log(root.filtered)
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

    Rectangle {
        anchors.fill: parent
        radius: 12
        color: "#1e1e1e"

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Return && filtered.length > 0) {
                runner.command = filtered[0]
                runner.startDetached()
                root.visible = false
                items.length = 0
            } else if (event.key === Qt.Key_Escape) {
                root.visible = false
                items.length = 0
            }
        }

        Column {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            TextField {
                id: input
                width: parent.width
                placeholderText: "Run..."
                focus: true
                onTextChanged: root.changed()
            }

            ListView {
                width: parent.width
                height: 150
                model: filtered

                delegate: Rectangle {
                    width: parent.width
                    height: 36

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData
                        color: "black"
                        leftPadding: 8
                    }
                }
            }
        }
    }
}
