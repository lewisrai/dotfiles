import Quickshell.Io

import "./Common/"

StyledText {
    Process {
        command: ["mmsg", "watch", "focusing-client"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                text = JSON.parse(data).appid
            }
        }
    }
}
