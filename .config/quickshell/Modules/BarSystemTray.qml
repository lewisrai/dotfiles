import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray

Repeater {
    model: SystemTray.items

    delegate: Item {
        id: trayItem
        width: 24
        height: 24

        Image {
            anchors.centerIn: parent
            width: 20
            height: 20
            fillMode: Image.PreserveAspectFit
            source: modelData.icon
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: function(mouse) {
                if (mouse.button === Qt.LeftButton) {
                    modelData.activate()
                } else if (mouse.button === Qt.RightButton) {
                    trayMenu.open()
                }
            }
        }

        QsMenuAnchor {
            id: trayMenu
            menu: modelData.menu
            anchor.item: trayItem
            anchor.edges: Edges.Bottom | Edges.Right
        }
    }
}
