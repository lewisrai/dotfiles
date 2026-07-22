import QtQuick
import Quickshell.Bluetooth

Text {
    readonly property BluetoothAdapter bluetooth: Bluetooth.defaultAdapter

    text: {
        switch (bluetooth?.state) {
            case BluetoothAdapterState.Disabled:
                return "󰂲 off"
            case BluetoothAdapterState.Enabled:
                return "󰂲 on"
            case BluetoothAdapterState.Disabling:
                return "󰂲 ~off"
            case BluetoothAdapterState.Blocked:
                return "󰂲 off!"
            case BluetoothAdapterState.Enabling:
                return "󰂲 ~on"
        }
    }
}
