import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "./Common/"

FloatingWindow {
    id: launcher

    property list<string> filtered: []
    property list<string> items: []
    property int selected: 0

    function close() {
        this.visible = false;

        this.filtered.length = 0;
        this.items.length = 0;
        this.selected = 0;

        input.clear();
    }

    function update() {
        this.filtered = this.items.filter(i => i.includes(input.text)).slice(0, 8);

        if (this.selected >= this.filtered.length)
            this.selected = this.filtered.length ? this.filtered.length - 1 : 0;
    }

    color: "#1e1e2e"
    implicitHeight: 196
    implicitWidth: 396
    title: "launcher"
    visible: false

    Process {
        id: get

        command: ["ls", "/usr/bin"]
        running: false

        stdout: SplitParser {
            onRead: data => {
                launcher.items.push(data);
            }
        }

        onExited: launcher.update()
    }

    IpcHandler {
        function open(): void {
            launcher.visible = true;
            get.running = true;
        }

        target: "launcher"
    }

    TextField {
        id: input

        background: null
        focus: true
        font.bold: true
        font.family: "FiraMonoNerdFont"
        font.pixelSize: 16
        height: 20
        padding: 0
        width: 380
        x: 8
        y: 8

        cursorDelegate: Rectangle {
            height: 0
            width: 0
        }

        Keys.onPressed: function (event) {
            switch (event.key) {
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
        onAccepted: {
            if (this.text)
                Runner.exec(filtered[selected]);
            launcher.close();
        }
        onTextChanged: launcher.update()
    }

    ListView {
        height: 160
        model: filtered
        width: 380
        x: 8
        y: 28

        delegate: StyledText {
            color: index === launcher.selected ? "#f9e2af" : "#f5c2e7"
            text: modelData
        }
    }
}
