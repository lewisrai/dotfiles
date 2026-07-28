import Quickshell.Io

import "./Common/"

StyledText {
    id: client

    Process {
        command: ["mmsg", "watch", "focusing-client"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                client.text = JSON.parse(data).appid;
            }
        }
    }
}
