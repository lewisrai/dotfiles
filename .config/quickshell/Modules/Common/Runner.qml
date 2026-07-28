pragma Singleton

import QtQuick
import Quickshell.Io

QtObject {
    readonly property Process process: Process {
    }

    function exec(command) {
        process.command = ["sh", "-c", command];
        process.startDetached();
    }
}
