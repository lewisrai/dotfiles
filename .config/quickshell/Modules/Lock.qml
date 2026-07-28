import QtQuick
import QtQuick.Controls
import Quickshell.Wayland

import "./Common/"

WlSessionLock {
    WlSessionLockSurface {
        Image {
            anchors.fill: parent
            source: "../wallpaper.png"
        }

        StyledRectangle {
            height: 48
            width: 300
            x: 1130
            y: 776

            TextField {
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

                onAccepted: {
                    pam.unlock(text);
                    this.clear();
                }
            }
        }
    }
}
