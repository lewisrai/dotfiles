import Quickshell.Io

SocketServer {
    active: true
    path: "/tmp/quickshell.sock"

    handler: Socket {
        parser: SplitParser {
            onRead: message => {
                switch (message) {
                    case "launcher": launcher.open(); return
                    case "lock": lock.locked = true; return
                }
            }
        }
    }
}
