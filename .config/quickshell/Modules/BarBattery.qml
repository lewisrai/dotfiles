import Quickshell.Io
import Quickshell.Services.UPower

import "./Common/"

StyledText {
    readonly property UPowerDevice battery: UPower.displayDevice
    readonly property string batteryText: {
        if (!this.battery)
            return " ~ ~~%";

        const charge = Math.round(this.battery.percentage * 100);
        const icon = this.battery.state === UPowerDeviceState.Charging ? " 󰂄 " : charge < 10 ? " 󰂎 " : charge < 30 ? " 󰁻 " : charge < 50 ? " 󰁽 " : charge < 70 ? " 󰁿 " : charge < 90 ? " 󰂁 " : " 󰁹 ";
        const text = charge < 10 ? "~" + charge + "%" : charge < 100 ? charge + "%" : "~C%";

        return icon + text;
    }
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

    text: powerProfileIcon + batteryText

    FileView {
        id: profile

        path: "/sys/firmware/acpi/platform_profile"
        watchChanges: true

        onFileChanged: this.reload()
    }
}
