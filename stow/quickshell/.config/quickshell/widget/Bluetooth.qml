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
    implicitWidth: container.implicitWidth
    implicitHeight: container.implicitHeight

    readonly property var connectedDevices: Bluetooth.devices.values.filter(d => d.connected)

    function bluetoothIcon() {
        if (connectedDevices.length > 0) return "󰂯"
        return "󰂲"
    }

    Rectangle {
        id: container
        implicitWidth: row.implicitWidth + 10
        implicitHeight: 25
        anchors.centerIn: parent
        color: Theme.primary
        radius: 6

        RowLayout {
            id: row
            spacing: 4
            anchors.centerIn: parent

            StyledText {
                text: root.bluetoothIcon()
                font.pixelSize: 16
                color: Theme.on_primary
            }
            StyledText {
                visible: root.connectedDevices.length > 0
                text: root.connectedDevices[0].name + (root.connectedDevices.length > 1 ? " +" + (root.connectedDevices.length - 1) : "") + " (" + root.connectedDevices[0].battery * 100 + "%)"
                color: Theme.on_primary_container
            }
        }
    }
}