import QtQuick

import "./Common/"

StyledText {
    readonly property var locale: Qt.locale()

    Timer {
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: text = locale.toString(new Date(), "ddd dd - HH:mm")
    }
}
