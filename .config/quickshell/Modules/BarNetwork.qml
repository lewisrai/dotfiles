import QtQuick
import Quickshell.Io

import "./Common/"

StyledText {
    id: network

    property bool connected: false
    property bool on: false
    property bool wireguardState: false

    text: {
        var networkText = "";

        if (!on)
            networkText = " off";
        else if (!connected)
            networkText = "  on";
        else if (!wireguardState)
            networkText = " con";
        else
            networkText = "  wg";

        return (on ? connected ? "󰤨" : "󰤫" : "󰤮") + " " + (wireguardState ? "󱎚" : "󱚰") + networkText;
    }

    Process {
        command: ["ip", "monitor", "link"]
        running: true

        stdout: SplitParser {
            onRead: {
                timer.restarting = true;
                timer.restart();
                timer.restarting = false;
            }
        }
    }

    Timer {
        id: timer

        property bool restarting: false

        interval: 1000

        onRunningChanged: {
            if (!restarting && !this.running) {
                iwd.running = true;
                wireguard.running = true;
            }
        }
    }

    Process {
        id: iwd

        property var output: []

        command: ["iwctl", "station", "wlan0", "show"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                iwd.output.push(data);
            }
        }

        onExited: {
            network.on = this.output.length !== 1;

            if (network.on) {
                const [, state] = this.output[5].trim().split(/\s+/);
                network.connected = state === "connected";
            } else {
                network.connected = false;
            }

            this.output.length = 0;
        }
    }

    Process {
        id: wireguard

        command: ["wg", "show"]
        running: true

        onExited: code => network.wireguardState = code
    }
}
