import Quickshell

import "./Common/"

StyledText {
    readonly property var locale: Qt.locale()

    text: this.locale.toString(clock.date, "ddd dd - HH:mm")

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }
}
