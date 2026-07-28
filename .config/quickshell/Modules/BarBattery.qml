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
        var batteryLevel = Math.round((this.battery?.percentage ?? 0) * 100);
        var batteryText = "";

        if (this.battery?.state === UPowerDeviceState.Charging)
            batteryText = "󰂄" + " " + batteryLevel + "%";
        else if (batteryLevel < 10)
            batteryText = "󰂎" + " " + batteryLevel + "%";
        else if (batteryLevel < 30)
            batteryText = "󰁻" + " " + batteryLevel + "%";
        else if (batteryLevel < 50)
            batteryText = "󰁽" + " " + batteryLevel + "%";
        else if (batteryLevel < 70)
            batteryText = "󰁿" + " " + batteryLevel + "%";
        else if (batteryLevel < 90)
            batteryText = "󰂁" + " " + batteryLevel + "%";
        else
            batteryText = "󰁹" + " " + batteryLevel + "%";

        return powerProfileIcon + " " + batteryText;
    }
}
