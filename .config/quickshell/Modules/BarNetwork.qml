import QtQuick
import Quickshell.Networking

import "./Common/"

StyledText {
    readonly property var firstDevice: Networking.devices.values?.[0]
    readonly property var firstNetwork: firstDevice?.networks.values?.[0]

    text: {
        switch (firstDevice?.state) {
            case ConnectionState.Connected: {
                const strength = firstNetwork?.signalStrength

                if (strength > 0.75) return `󰤨 ${firstDevice.name}`
                else if (strength > 0.5) return `󰤥 ${firstDevice.name}`
                else if (strength > 0.25) return `󰤢 ${firstDevice.name}`
                else if (strength > 0) return `󰤟 ${firstDevice.name}`
                else return `󰤮 ${firstDevice.name}`
            }
            case ConnectionState.Connecting: return `~ ${firstDevice.name}`
            case ConnectionState.Disconnected: return `󰤮 ${firstDevice.name}`
            case ConnectionState.Disconnecting: return `~ ${firstDevice.name}`
            default: return "󰤮   off"
        }
    }
}
