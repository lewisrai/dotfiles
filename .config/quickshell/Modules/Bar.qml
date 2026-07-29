import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import "./Common/"
import "./"

PanelWindow {
    WlrLayershell.layer: WlrLayer.Top
    anchors.left: true
    anchors.right: true
    anchors.top: true
    color: "transparent"
    implicitHeight: 52

    StyledRectangle {
        width: 303
        x: 28

        BarActiveTag {
            id: abcd
            anchors.centerIn: parent
        }
    }

    StyledRectangle {
        implicitWidth: client.implicitWidth + 28
        visible: client.text
        x: 345

        BarActiveClient {
            id: client

            anchors.centerIn: parent
        }
    }

    StyledRectangle {
        width: 150
        x: 1205

        BarClock {
            anchors.centerIn: parent
        }
    }

    StyledRectangle {
        visible: notifications.text
        width: 400
        x: 1483

        BarNotifications {
            id: notifications

            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 14
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
        }
    }

    StyledRectangle {
        implicitWidth: tray.implicitWidth + 28
        x: 2112 - tray.implicitWidth

        BarSystemTray {
            id: tray

            anchors.centerIn: parent
        }
    }

    StyledRectangle {
        color: bluetoothArea.containsMouse ? "#f5c2e7" : "#1e1e2e"
        width: 76
        x: 2154

        BarBluetooth {
            anchors.centerIn: parent
            color: bluetoothArea.containsMouse ? "#1e1e2e" : "#f5c2e7"
        }

        MouseArea {
            id: bluetoothArea

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onClicked: Runner.exec("pkill blueman-manager || blueman-manager")
        }
    }

    StyledRectangle {
        width: 76
        x: 2244

        BarBrightness {
            anchors.centerIn: parent
        }
    }

    StyledRectangle {
        color: audioArea.containsMouse ? "#f5c2e7" : "#1e1e2e"
        width: 92
        x: 2334

        BarAudio {
            anchors.centerIn: parent
            color: audioArea.containsMouse ? "#1e1e2e" : "#f5c2e7"
        }

        MouseArea {
            id: audioArea

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onClicked: Runner.exec("pkill pwvucontrol || pwvucontrol")
        }
    }

    StyledRectangle {
        width: 92
        x: 2440

        BarBattery {
            anchors.centerIn: parent
        }
    }
}
