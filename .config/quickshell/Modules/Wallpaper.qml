import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusionMode: ExclusionMode.Ignore

    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true

    Image {
        anchors.fill: parent
        cache: true
        source: "../wallpaper.png"
    }
}
