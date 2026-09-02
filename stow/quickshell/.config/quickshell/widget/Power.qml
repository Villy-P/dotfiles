import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import ".."
import "../components"

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    property int battery: Math.round(UPower.displayDevice.percentage * 100)
    property var popupHost

    visible: UPower.displayDevice.isPresent

    function batteryIcon(battery) {
        if (battery < 10) return "󰂃"
        if (battery < 20) return "󰁻"
        if (battery < 30) return "󰁼"
        if (battery < 40) return "󰁽"
        if (battery < 50) return "󰁾"
        if (battery < 60) return "󰁿"
        if (battery < 70) return "󰂀"
        if (battery < 80) return "󰂁"
        if (battery < 90) return "󰂂"
        if (battery <= 100) return "󰁹"
        return "󰁽"
    }

    function getPowerColor(battery) {
        if (battery < 10) return "#CB4C4E";
        if (battery < 30) return "#E0D268";
        return "#77f6cb"
    }

    Rectangle {
        id: row
        color: root.getPowerColor(root.battery)
        implicitWidth: input_row.implicitWidth + 10
        implicitHeight: 25
        radius: 6

        RowLayout {
            id: input_row
            spacing: 4
            anchors.centerIn: parent

            StyledText {
                text: root.batteryIcon(root.battery)
                font.pixelSize: 16
                color: Theme.on_primary
            }

            StyledText {
                color: Theme.on_primary
                text: root.battery + (UPower.onBattery ? "%" : "󱐋")
            }
        }
    }

    HoverHandler {
        id: iconHover
        cursorShape: Qt.PointingHandCursor
        onHoveredChanged: {
            if (iconHover.hovered) {
                root.popupHost.activate(root, powerContent, 700, 500)
            } else {
                root.popupHost.deactivate(root)
            }
        }
    }

    Component {
        id: powerContent

        Item {
            StyledText {
                text: "Power settings"
            }
        }
    }
}
