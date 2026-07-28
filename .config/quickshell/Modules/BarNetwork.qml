import QtQuick
import Quickshell.Networking

import "./Common/"

StyledText {
    readonly property var firstDevice: Networking.devices.values?.[0]
    readonly property var firstNetwork: this.firstDevice?.networks.values?.[0]

    text: {
        switch (this.firstDevice?.state) {
        case ConnectionState.Connected:
            {
                const strength = this.firstNetwork?.signalStrength;

                if (!strength)
                    return `󰤮 ${this.firstDevice.name}`;
                if (strength < 0.25)
                    return `󰤟 ${this.firstDevice.name}`;
                else if (strength < 0.5)
                    return `󰤢 ${this.firstDevice.name}`;
                else if (strength < 0.75)
                    return `󰤥 ${this.firstDevice.name}`;
                else
                    return `󰤨 ${this.firstDevice.name}`;
            }
        case ConnectionState.Connecting:
            return `~ ${this.firstDevice.name}`;
        case ConnectionState.Disconnected:
            return `󰤮 ${this.firstDevice.name}`;
        case ConnectionState.Disconnecting:
            return `~ ${this.firstDevice.name}`;
        default:
            return "󰤮   off";
        }
    }
}
