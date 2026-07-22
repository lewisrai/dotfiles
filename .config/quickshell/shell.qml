//@ pragma UseQApplication

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import "./Modules/"

ShellRoot {
    Bar {}

    Notifications {}

    Wallpaper {}
}
