import QtQuick
import QtQuick.Controls.Fusion
import Quickshell.Services.Pam
import Quickshell.Wayland

import "./Common/"

WlSessionLock {
    id: lock

    WlSessionLockSurface {
        Image {
            anchors.fill: parent
            source: "../wallpaper.png"
        }

        StyledRectangle {
            x: 1130
            y: 776
            width: 300
            height: 48

            TextField {
                anchors.centerIn: parent
                y: 200
                color: "#f5c2e7"
                background: null
                cursorDelegate: Rectangle { width: 0; height: 0 }
                echoMode: TextInput.Password
                focus: true
                onAccepted: lock.locked = false
            }
        }
    }
}

