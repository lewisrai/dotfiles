import Quickshell.Io

Process {
    property string client: ""

    command: ["mmsg", "watch", "focusing-client"]
    running: true

    stdout: SplitParser {
        onRead: data => {
            var data = JSON.parse(data)
            client = data.appid
        }
    }
}
