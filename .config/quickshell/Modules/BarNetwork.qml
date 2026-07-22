import QtQuick
import Quickshell.Networking

Text {
    readonly property NetworkDevice network: Networking.devices.values[0]

    text: {
        const name = network?.name

        const strength = network?.networks.values[0].signalStrength

        var strengthIcon = "󰤮"

        if (strength > 0.75) strengthIcon = "󰤨"
        else if (strength > 0.5) strengthIcon = "󰤥"
        else if (strength > 0.25) strengthIcon = "󰤢"
        else if (strength > 0) strengthIcon = "󰤟"

        return `${strengthIcon}  ${name}`
    }
}
