import QtQuick

Text {
    Timer {
        property var locale: Qt.locale()

        interval: 1000
        running: true
        repeat: true
        onTriggered: parent.text = locale.toString(new Date(), "ddd dd - HH:mm")
    }
}
