import QtQuick
import Quickshell.Services.UPower

Text {
    readonly property UPowerDevice battery: UPower.displayDevice

    readonly property int batteryLevel: Math.round((battery?.percentage ?? 0) * 100)

    readonly property string batteryIcon: {
        if (battery.charging) return "󰂄"
        if (batteryLevel >= 90) return "󰁹"
        if (batteryLevel >= 70) return "󰂁"
        if (batteryLevel >= 50) return "󰁿"
        if (batteryLevel >= 30) return "󰁽"
        if (batteryLevel >= 10) return "󰁻"
        return "󰂎"
    }

    readonly property string powerProfileIcon: {
        switch (PowerProfiles.profile) {
            case PowerProfile.PowerSaver:
                return ""
            case PowerProfile.Balanced:
                return ""
            case PowerProfile.Performance:
                return "󱪂"
            default:
                return "~"
        }
    }

    text: `${powerProfileIcon} ${batteryIcon} ${batteryLevel}%`
}
