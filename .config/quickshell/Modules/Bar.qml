import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

import "./Common/"
import "./"

PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    color: "transparent"
    implicitHeight: 52

    WlrLayershell.layer: WlrLayer.Top

    StyledRectangle {
        implicitWidth: 175
        x: 28

        BarActiveTag {
            anchors.centerIn: parent
        }
    }

    StyledRectangle {
        implicitWidth: tray.implicitWidth + 28
        x: 217

        BarSystemTray {
            id: tray
            anchors.centerIn: parent
        }
    }

    StyledRectangle {
        implicitWidth: client.implicitWidth + 28
        x: 259 + tray.implicitWidth

        visible: client.text

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
        width: 400
        x: 1495

        visible: notif.text

        BarNotifications {
            id: notif
            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 14
            elide: Text.ElideRight
            wrapMode: Text.NoWrap
            verticalAlignment: Text.AlignVCenter
        }
    }

    StyledRectangle {
        width: 96
        x: 2044

        BarNetwork {
            anchors.centerIn: parent
        }
    }

    StyledRectangle {
        width: 76
        x: 2154

        color: mouseArea1.containsMouse ? "#f5c2e7" : "#1e1e2e"

        BarBluetooth {
            anchors.centerIn: parent
        }

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                runner2.command = ["sh", "-c", "pkill blueman-manager || blueman-manager"]
                runner2.startDetached()
            }
        }

        Process {
            id: runner2
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
        width: 92
        x: 2334

        color: mouseArea2.containsMouse ? "#f5c2e7" : "#1e1e2e"

        BarAudio {
            anchors.centerIn: parent
        }

        MouseArea {
            id: mouseArea2
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                runner3.command = ["sh", "-c", "pkill pwvucontrol || pwvucontrol"]
                runner3.startDetached()
            }
        }

        Process {
            id: runner3
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
