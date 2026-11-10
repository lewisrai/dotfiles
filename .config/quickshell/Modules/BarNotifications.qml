import QtQuick
import Quickshell.Services.Notifications

import "./Common/"

StyledText {
    readonly property Notification current: server.trackedNotifications.values[0] ?? null

    color: current?.urgency === NotificationUrgency.Critical ? "#f38ba8" : "#f5c2e7"
    text: current ? current.summary + " " + current.body : ""

    NotificationServer {
        id: server

        onNotification: notification => {
            const tag = notification.hints["tag"];

            if (tag) {
                this.trackedNotifications.values.find(n => n.hints["tag"] === tag)?.dismiss();
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
