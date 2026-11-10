import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Polkit
import Quickshell.Wayland

import "./Common/"

FloatingWindow {
    color: "#1e1e2e"
    implicitHeight: 196
    implicitWidth: 396
    title: "polkit"
    visible: agent.flow

    PolkitAgent {
        id: agent
    }

    Rectangle {
        color: "#1e1e2e"
        height: 14
        width: 380
        x: 8
        y: 8

        StyledText {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            text: agent.flow ? agent.flow.message : ""
            wrapMode: Text.WordWrap
        }
    }

    StyledRectangle {
        height: 48
        width: 400
        x: -2
        y: 150

        TextField {
            id: password

            anchors.centerIn: parent
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

            Keys.onPressed: function (event) {
                if (event.key === Qt.Key_Escape) {
                    agent.flow.cancelAuthenticationRequest();
                }
            }
            onAccepted: agent.flow.submit(this.text)
        }
    }
}
