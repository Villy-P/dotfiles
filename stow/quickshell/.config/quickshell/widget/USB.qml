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

    property int devices: 0

    Process {
        id: checkUSBProc
        command: ["bash", "-c", "lsblk -o NAME,TRAN | grep usb | wc -l"]
        stdout: SplitParser {
            onRead: data => {
                root.devices = parseInt(data) || 0
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: checkUSBProc.running = true
    }

    Rectangle {
        id: container
        implicitWidth: row.implicitWidth + 10
        implicitHeight: 25
        anchors.centerIn: parent
        color: Theme.secondary_container
        radius: 6

        RowLayout {
            id: row
            spacing: 4
            anchors.centerIn: parent

            StyledText {
                text: "󰕓"
                font.pixelSize: 16
                color: Theme.on_secondary_container
            }
            StyledText {
                visible: root.devices > 0
                text: root.devices
                color: Theme.on_secondary_container
            }
        }
    }
}