import Quickshell.Io
import Quickshell.Services.UPower

import "./Common/"

StyledText {
    readonly property UPowerDevice battery: UPower.displayDevice
    readonly property string powerProfileIcon: {
        switch (profile.text().trim()) {
        case "quiet":
            return "";
        case "balanced":
            return "";
        case "performance":
            return "󱪂";
        default:
            return "~";
        }
    }

    FileView {
        id: profile

        path: "/sys/firmware/acpi/platform_profile"
        watchChanges: true

        onFileChanged: this.reload()
    }

    text: {
        var batteryText = " ~ ~~%";

        if (this.battery) {
            const batteryLevel = Math.round(this.battery.percentage * 100);
            const charging = this.battery.state === UPowerDeviceState.Charging;

            if (batteryLevel < 10)
                batteryText = (charging ? " 󰂄 ~" : " 󰂎 ~") + batteryLevel + "%";
            else if (batteryLevel < 30)
                batteryText = (charging ? " 󰂄 " : " 󰁻 ") + batteryLevel + "%";
            else if (batteryLevel < 50)
                batteryText = (charging ? " 󰂄 " : " 󰁽 ") + batteryLevel + "%";
            else if (batteryLevel < 70)
                batteryText = (charging ? " 󰂄 " : " 󰁿 ") + batteryLevel + "%";
            else if (batteryLevel < 90)
                batteryText = (charging ? " 󰂄 " : " 󰂁 ") + batteryLevel + "%";
            else if (batteryLevel < 100)
                batteryText = (charging ? " 󰂄 " : " 󰁹 ") + batteryLevel + "%";
            else
                batteryText = (charging ? " 󰂄 " : " 󰁹 ") + "~C%";
        }

        return powerProfileIcon + batteryText;
    }
}
