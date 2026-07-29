import QtQuick
import Quickshell.Services.Notifications

import "./Common/"

StyledText {
    property alias all: server.trackedNotifications

    color: all.values[0]?.urgency === NotificationUrgency.Critical ? "#f38ba8" : "#f5c2e7"
    text: all.values.length ? all.values[0].summary + " " + all.values[0].body : ""

    NotificationServer {
        id: server

        onNotification: notification => {
            const tag = notification.hints["tag"];

            if (tag) {
                for (const tracked of all.values) {
                    if (tracked.hints["tag"] === tag)
                        tracked.dismiss();
                }
            }

            notification.tracked = true;
        }
    }

    Timer {
        interval: 4000
        running: all.values.length

        onTriggered: all.values[0].dismiss()
    }
}
