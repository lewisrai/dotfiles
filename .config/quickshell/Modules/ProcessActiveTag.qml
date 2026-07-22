import Quickshell.Io

Process {
    property int tag: 1

    command: ["mmsg", "watch", "all-tags"]
    running: true

    stdout: SplitParser {
        onRead: data => {
            var data = JSON.parse(data)
            tag = data.all_tags[0].tags.find(t => t.is_active)?.index
        }
    }
}
