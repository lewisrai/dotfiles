import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pam
import Quickshell.Wayland

import "./Common/"

Scope {
    PamContext {
        id: pam

        property string password: ""

        function unlock(password) {
            if (!password)
                return;
            this.password = password;
            this.start();
        }

        onCompleted: result => {
            this.password = "";

            if (!result)
                lock.locked = false;
        }
        onPamMessage: if (this.responseRequired)
            this.respond(this.password)
    }

    IpcHandler {
        target: "lock"

        function lock(): void {
            lock.locked = true;
        }
    }

    WlSessionLock {
        id: lock

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
}
