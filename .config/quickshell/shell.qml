//@ pragma DefaultEnv QS_DISABLE_CRASH_HANDLER=1
//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
//@ pragma DropExpensiveFonts
//@ pragma UseQApplication

import QtQuick
import Quickshell
import Quickshell.Wayland

import "./Modules/"

ShellRoot {
    Bar {
    }

    Launcher {
    }

    Lock {
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
