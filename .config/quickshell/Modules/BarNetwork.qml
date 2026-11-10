import QtQuick
import Quickshell.Io

import "./Common/"

StyledText {
    id: network

    property bool connected: false
    property bool on: false
    property bool wireguardState: false

    text: {
        const wifiIcon = this.on ? this.connected ? "󰤨 " : "󰤫 " : "󰤮 ";
        const wireguardIcon = this.wireguardState ? "󱎚" : "󱚰";
        const networkText = this.on ? this.connected ? this.wireguardState ? "  wg" : " con" : "  on" : " off";

        return wifiIcon + wireguardIcon + networkText;
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
            if (!this.restarting && !this.running) {
                iwd.running = true;
                wireguard.running = true;
            }
        }
    }

    Process {
        id: iwd

        property list<string> output: []

        command: ["iwctl", "station", "wlan0", "show"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                iwd.output.push(data);
            }
        }

        onExited: {
            network.on = this.output.length !== 1;
            network.connected = network.on ? this.output[5].trim().split(/\s+/)[1] === "connected" : false;

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
