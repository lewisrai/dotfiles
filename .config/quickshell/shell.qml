//@ pragma DefaultEnv QS_DISABLE_CRASH_HANDLER=1
//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
//@ pragma DropExpensiveFonts
//@ pragma UseQApplication

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pam
import Quickshell.Wayland

import "./Modules/"

ShellRoot {
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

    SocketServer {
        active: true
        path: "/tmp/quickshell.sock"

        handler: Socket {
            id: socket

            parser: SplitParser {
                onRead: message => {
                    socket.connected = false;

                    switch (message) {
                    case "launcher":
                        launcher.open();
                        break;
                    case "lock":
                        lock.locked = true;
                        break;
                    }
                }
            }
        }
    }

    Bar {
    }

    Launcher {
        id: launcher
    }

    Lock {
        id: lock
    }

    Polkit {
    }

    PanelWindow {
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Background
        anchors.bottom: true
        anchors.left: true
        anchors.right: true
        anchors.top: true

        Image {
            anchors.fill: parent
            source: "wallpaper.png"
        }
    }
}
