import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland

Scope {
    NotificationServer {
        id: server

        onNotification: n => {
            const tag = n.hints["tag"]

            if (tag) {
                for (const index in trackedNotifications.values) {
                    if (trackedNotifications.values[index].hints["tag"] === tag) {
                        trackedNotifications.values[index].dismiss()
                    }
                }
            }

            n.tracked = true
        }
    }

    Timer {
        interval: 4000
        repeat: true
        running: server.trackedNotifications.values.length > 0
        onTriggered: {
            if (server.trackedNotifications.values.length > 0)
                server.trackedNotifications.values[0].dismiss()
        }
    }

    PanelWindow {
        WlrLayershell.exclusionMode: ExclusionMode.Ignore

        anchors.top: true
        margins.top: 12

        implicitWidth: 300
        implicitHeight: 32

        color: "transparent"

        Text {
            anchors.centerIn: parent
            text: server.trackedNotifications.values.length > 0
                ? server.trackedNotifications.values[0].summary + " " + server.trackedNotifications.values[0].body
                : ""
        }
    }
}
