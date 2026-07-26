//@ pragma DefaultEnv QS_DISABLE_CRASH_HANDLER=1
//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
//@ pragma DropExpensiveFonts
//@ pragma UseQApplication

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import "./Modules/"

ShellRoot {
    Bar {}

    Launcher { id: launcher }

    Lock { id: lock }

    Polkit {}

    SocketServer {
        active: true
        path: "/tmp/quickshell.sock"
        handler: Socket {
            parser: SplitParser {
                onRead: message => {
                    switch (message) {
                        case "launcher": launcher.open(); break
                        case "lock": lock.locked = true; break
                    }
                    connected = false
                }
            }
        }
    }

    PanelWindow {
        anchors.bottom: true
        anchors.left: true
        anchors.right: true
        anchors.top: true

        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Background

        Image {
            anchors.fill: parent
            source: "wallpaper.png"
        }
    }
}
