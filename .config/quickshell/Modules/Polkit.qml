import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Polkit
import Quickshell.Wayland

FloatingWindow {
    title: "polkit"
    visible: agent.flow

    width: 300
    height: 200

    PolkitAgent {
        id: agent
    }

    ColumnLayout {
        spacing: 12
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            text: agent.flow.message
        }

        TextField {
            id: passwordInput
            echoMode: TextInput.Password
            placeholderText: "Password"
            focus: true
            Layout.fillWidth: true
        }

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Return) {
                agent.flow.submit(passwordInput.text)
                passwordInput.text = ""
            } else if (event.key === Qt.Key_Escape) {
                agent.flow.cancelAuthenticationRequest()
            }
        }
    }
}
