import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Polkit
import Quickshell.Wayland

import "./Common/"

FloatingWindow {
    color: "#1e1e2e"
    implicitHeight: 212
    implicitWidth: 424
    title: "polkit"
    visible: agent.flow

    PolkitAgent {
        id: agent
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14

        Keys.onPressed: function (event) {
            if (event.key === Qt.Key_Escape) {
                agent.flow.cancelAuthenticationRequest();
                password.clear();
            }
        }

        StyledText {
            Layout.fillWidth: true
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            text: "Polkit"
        }

        StyledText {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: agent.flow ? agent.flow.message : ""
            wrapMode: Text.WordWrap
        }

        TextField {
            id: password

            Layout.alignment: Qt.AlignHCenter
            background: null
            color: "#f5c2e7"
            echoMode: TextInput.Password
            focus: true
            placeholderText: ""
            placeholderTextColor: "#f5c2e7"

            cursorDelegate: Rectangle {
                height: 0
                width: 0
            }

            onAccepted: {
                agent.flow.submit(this.text);
                this.clear();
            }
        }
    }
}
