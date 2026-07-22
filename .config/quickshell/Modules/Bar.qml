import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "./"

PanelWindow {
    id: bar

    WlrLayershell.layer: WlrLayer.Top

    anchors.top: true
    anchors.left: true
    anchors.right: true

    implicitHeight: 56

    color: "transparent"

    ProcessActiveClient { id: activeClient }

    ProcessActiveTag { id: activeTag }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        BarActiveTag {}

        BarSystemTray {}

        BarActiveClient {}

        BarClock {}

        Item {
            Layout.fillWidth: true
        }

        BarNetwork {}

        BarBluetooth {}

        BarBrightness {}

        BarAudio {}

        BarBattery {}
    }
}
