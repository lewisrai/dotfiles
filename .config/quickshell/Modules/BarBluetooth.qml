import Quickshell.Bluetooth

import "./Common/"

StyledText {
    readonly property BluetoothAdapter bluetooth: Bluetooth.defaultAdapter

    text: {
        switch (this.bluetooth?.state) {
        case BluetoothAdapterState.Disabling:
            return "󰂲  on";
        case BluetoothAdapterState.Enabled:
            return "󰂲  on";
        default:
            return "󰂲 off";
        }
    }
}
