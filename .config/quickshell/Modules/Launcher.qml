import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "./Common/"

FloatingWindow {
    id: launcher

    property var filtered: []
    property var items: []
    property int selected: 0

    function changed() {
        this.filtered = this.items.filter(i => i.includes(input.text)).slice(0, 8);

        if (this.selected >= this.filtered.length)
            this.selected = this.filtered.length ? this.filtered.length - 1 : 0;
    }

    function close() {
        launcher.visible = false;
        input.clear();
        items.length = 0;
        selected = 0;
    }

    function open() {
        visible = true;
        get.running = true;
    }

    color: "#1e1e2e"
    implicitHeight: 212
    implicitWidth: 424
    title: "launcher"
    visible: false

    Process {
        id: get

        command: ["ls", "/usr/bin"]
        running: false

        stdout: SplitParser {
            onRead: data => {
                items.push(data);
            }
        }

        onRunningChanged: launcher.changed()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 0

        Keys.onPressed: function (event) {
            switch (event.key) {
            case Qt.Key_Return:
                if (!filtered.length)
                    return;
                Runner.exec(filtered[selected]);
            case Qt.Key_Escape:
                launcher.close();
                break;
            case Qt.Key_Up:
                if (launcher.selected != 0)
                    selected--;
                break;
            case Qt.Key_Down:
                if (launcher.selected != launcher.filtered.length - 1)
                    selected++;
                break;
            }
        }

        TextField {
            id: input

            background: null
            focus: true
            width: parent.width

            cursorDelegate: Rectangle {
                height: 0
                width: 0
            }

            onTextChanged: launcher.changed()
        }

        ListView {
            height: parent.height
            model: filtered
            width: parent.width

            delegate: Rectangle {
                color: "#1e1e2e"
                height: 20
                width: parent.width

                StyledText {
                    color: index == launcher.selected ? "#f9e2af" : "#f5c2e7"
                    leftPadding: 4
                    text: modelData
                }
            }
        }
    }
}
