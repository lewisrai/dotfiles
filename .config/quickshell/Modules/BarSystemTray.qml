import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray

RowLayout {
    spacing: 14

    Repeater {
        model: SystemTray.items

        delegate: Item {
            id: trayItem

            height: 20
            width: 20

            Image {
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: modelData.icon
            }

            MouseArea {
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onClicked: function (mouse) {
                    switch (mouse.button) {
                    case Qt.LeftButton:
                        modelData.activate();
                    case Qt.RightButton:
                        trayMenu.open();
                    }
                }
            }

            QsMenuAnchor {
                id: trayMenu

                anchor.edges: Edges.Bottom | Edges.Right
                anchor.item: trayItem
                menu: modelData.menu
            }
        }
    }
}
