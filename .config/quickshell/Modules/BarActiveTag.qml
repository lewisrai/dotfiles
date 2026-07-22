import QtQuick

Repeater {
    model: 5

    Text {
        text: index + 1 === activeTag.tag ? "" : ""
    }
}
