import QtQuick
import Quickshell.Services.Notifications

import "./Common/"

StyledText {
    text: server.trackedNotifications.values.length > 0 ? server.trackedNotifications.values[0].summary + " " + server.trackedNotifications.values[0].body : ""

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
        running: server.trackedNotifications.values.length > 0

        onTriggered: server.trackedNotifications.values[0].dismiss()
    }
}
