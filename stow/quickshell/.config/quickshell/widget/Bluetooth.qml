import QtQuick
import Quickshell.Bluetooth
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import ".."
import "../components"

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    readonly property var connectedDevices: Bluetooth.devices.values.filter(d => d.connected)

    function bluetoothIcon() {
        if (connectedDevices.length > 0) return "󰂯"
        return "󰂲"
    }

    RowLayout {
        id: row
        spacing: 4

        StyledText {
            text: root.bluetoothIcon()
            font.pixelSize: 16
            color: "#77f6cb"
        }

        StyledText {
            text: root.connectedDevices[0].name + (root.connectedDevices.length > 1 ? " +" + (root.connectedDevices.length - 1) : "")
        }
    }
}