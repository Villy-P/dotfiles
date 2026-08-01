import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import ".."

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    property bool connected: false
    property string ssid: ""
    property int signalStrength: 0

    function wifiIcon() {
        if (!connected) return "󰤭"
        if (signalStrength > 80) return "󰤨"
        if (signalStrength > 55) return "󰤥"
        if (signalStrength > 30) return "󰤢"
        return "󰤟"
    }

    Process {
        id: statusProcess
        command: ["sh", "-c", "nmcli -t -f active,ssid,signal dev wifi | grep ^yes"]
        stdout: SplitParser {
            onRead: data => {
                if (data) {
                    const parts = data.split(":");
                    root.connected = true;
                    root.ssid = parts[1] ?? "";
                    root.signalStrength = parseInt(parts[2]) || 0;
                } else {
                    root.connected = false;
                    root.ssid = "";
                    root.signalStrength = 0;
                }
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: statusProcess.running = true
    }

    RowLayout {
        id: row
        spacing: 4
        Text { text: root.wifiIcon(); font.pixelSize: 16; color: Theme.text }
        Text { visible: root.connected; text: root.ssid; color: Theme.text }
    }
}