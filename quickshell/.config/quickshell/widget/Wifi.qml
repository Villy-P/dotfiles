import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
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

    MouseArea {
        anchors.fill: parent
        onClicked: popup.visible = !popup.visible
        cursorShape: Qt.PointingHandCursor
    }

    PopupWindow {
        id: popup
        implicitWidth: 400
        implicitHeight: 300
        grabFocus: true
        anchor.item: root
        anchor.rect.x: 0
        anchor.rect.y: root.height

        color: Qt.rgba(
            Theme.surface.r,
            Theme.surface.g,
            Theme.surface.b,
            0.95
        )

        property var networks: []
        property string connectingSSID: ""
        property string errorText: ""

        onVisibleChanged: if (visible) rescan()

        function rescan() {
            errorText = ""
            scanProcess.running = true
        }

        Process {
            id: scanProcess
            command: [
                "sh", "-c", 
                "nmcli dev wifi rescan 2>/dev/null; sleep 1; nmcli -t -f in-use,ssid,signal,security dev wifi list"]
            stdout: StdioCollector {
                onStreamFinished: {
                    const lines = text.trim().split("\n").filter(line => line.length > 0)
                    const seen = new Set()
                    const results = []
                    for (const line of lines) {
                        const parts = line.split(":")
                        const inUse = parts[0] === "*"
                        const ssid = parts[1] || ""
                        const signal = parseInt(parts[2]) || 0
                        const security = parts[3] || ""
                        if (!ssid || seen.has(ssid)) continue
                        seen.add(ssid)
                        results.push({ inUse, ssid, signal, security })
                    }
                    results.sort((a, b) => b.signal - a.signal)
                    popup.networks = results
                }
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 4

            RowLayout {
                Text { text: "Wi-Fi Networks"; font.pixelSize: 16; color: Theme.text }
                Button { 
                    text: "⟳";
                    onClicked: popup.rescan()
                }
            }

            Text {
                visible: popup.errorText.length > 0
                text: popup.errorText
                color: Theme.error
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: popup.networks

                delegate: Item {
                    required property var modelData
                    width: ListView.view.width

                    property bool connecting: modelData.ssid === popup.connectingSSID
                    signal connectRequested(string ssid, string security)

                    implicitHeight: col.implicitHeight + 8
                    
                    property bool expanded: false

                    ColumnLayout {
                        id: col
                        width: parent.width
                        spacing: 4

                        RowLayout {
                            width: parent.width
                            Text {
                                text: (modelData.inUse ? "󰤨 " : "") + modelData.ssid
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                color: Theme.text
                            }
                            Text {
                                text: modelData.security ? "󰌾" : ""
                                color: Theme.text
                            }
                            Text {
                                text: modelData.signal + "%"
                                color: Theme.text
                            }
                        }
                    }
                }
            }
        }
    }
}