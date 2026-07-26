import QtQuick
import Quickshell.Services.Notifications

import "./Common/"

StyledText {
    NotificationServer {
        id: server

        onNotification: n => {
            const tag = n.hints["tag"]

            if (tag) {
                for (const tracked of trackedNotifications.values) {
                    if (tracked.hints["tag"] === tag) tracked.dismiss()
                }
            }

            n.tracked = true
        }
    }

    Timer {
        interval: 4000
        running: server.trackedNotifications.values.length > 0
        onTriggered: server.trackedNotifications.values[0].dismiss()
    }

    text: server.trackedNotifications.values.length > 0
        ? server.trackedNotifications.values[0].summary + " " + server.trackedNotifications.values[0].body
        : ""
}
