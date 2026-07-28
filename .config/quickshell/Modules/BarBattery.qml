import Quickshell.Services.UPower

import "./Common/"

StyledText {
    readonly property UPowerDevice battery: UPower.displayDevice
    readonly property string powerProfileIcon: {
        switch (PowerProfiles.profile) {
        case PowerProfile.PowerSaver:
            return "";
        case PowerProfile.Balanced:
            return "";
        case PowerProfile.Performance:
            return "󱪂";
        default:
            return "~";
        }
    }

    text: {
        var batteryIcon = "";
        var batteryLevel = Math.round((this.battery?.percentage ?? 0) * 100);

        if (this.battery?.state === UPowerDeviceState.Charging)
            batteryIcon = "󰂄";
        else if (batteryLevel < 10)
            batteryIcon = "󰂎";
        else if (batteryLevel < 30)
            batteryIcon = "󰁻";
        else if (batteryLevel < 50)
            batteryIcon = "󰁽";
        else if (batteryLevel < 70)
            batteryIcon = "󰁿";
        else if (batteryLevel < 90)
            batteryIcon = "󰂁";
        else
            batteryIcon = "󰁹";

        if (batteryLevel < 10)
            batteryLevel = "~" + batteryLevel;

        return powerProfileIcon + " " + batteryIcon + " " + batteryLevel + "%";
    }
}
