import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Polkit
import Quickshell.Wayland

import "./Common/"

FloatingWindow {
    title: "polkit"
    visible: agent.flow

    implicitWidth: 400
    implicitHeight: 200
    color: "#1e1e2e"

    PolkitAgent {
        id: agent
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24

        StyledText {
            Layout.fillWidth: true
            font.pixelSize: 28
            text: "Polkit"
            horizontalAlignment: Text.AlignHCenter
        }

        StyledText {
            Layout.fillWidth: true
            text: agent.flow ? agent.flow.message : ""
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: password

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 240
            horizontalAlignment: Text.AlignHCenter

            echoMode: TextInput.Password
            focus: true
        }

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Return) {
                agent.flow.submit(password.text)
                password.text = ""
            } else if (event.key === Qt.Key_Escape) {
                agent.flow.cancelAuthenticationRequest()
                password.text = ""
            }
        }
    }
}
