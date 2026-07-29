import QtQuick
import Quickshell.Services.Notifications

import "./Common/"

StyledText {
    color: server.trackedNotifications.values[0]?.urgency == NotificationUrgency.Critical ? "#f38ba8" : "#f5c2e7"
    text: server.trackedNotifications.values.length ? server.trackedNotifications.values[0].summary + " " + server.trackedNotifications.values[0].body : ""

    NotificationServer {
        id: server

        property alias notificationsList: server.trackedNotifications

        onNotification: notification => {
            const tag = notification.hints["tag"];

            if (tag) {
                for (const tracked of trackedNotifications.values) {
                    if (tracked.hints["tag"] === tag)
                        tracked.dismiss();
                }
            }

            notification.tracked = true;
        }
    }

    Timer {
        interval: 4000
        running: server.trackedNotifications.values.length

        onTriggered: server.trackedNotifications.values[0].dismiss()
    }
}
