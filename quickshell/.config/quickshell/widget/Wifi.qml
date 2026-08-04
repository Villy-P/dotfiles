import QtQuick
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

    property bool connected: false
    property string ssid: ""
    property int signalStrength: 0
    property var popupHost

    function wifiIcon(strength) {
        if (!connected) return "󰤭"
        if (strength > 80) return "󰤨"
        if (strength > 55) return "󰤥"
        if (strength > 30) return "󰤢"
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
        Text { text: root.wifiIcon(root.signalStrength); font.pixelSize: 16; color: Theme.text }
        Text { visible: root.connected; text: root.ssid; color: Theme.text }
    }

    HoverHandler {
        id: iconHover
        cursorShape: Qt.PointingHandCursor
        onHoveredChanged: {
            if (iconHover.hovered) {
                root.popupHost.activate(root, wifiContent, 400, 700)
            } else {
                root.popupHost.deactivate(root)
            }
        }
    }

    Component {
        id: wifiContent

        Item {
            id: contentRoot

            property var networks: []
            property string connectingSSID: ""
            property string errorText: ""

            Component.onCompleted: rescan()

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
                        const lines = text.split("\n").filter(line => line.length > 0)
                        const seen = new Set()
                        const results = []
                        for (const line of lines) {
                            const parts = line.split(":")
                            const inUse = parts[0] == "*"
                            const ssid = parts[1] || ""
                            const signal = parseInt(parts[2]) || 0
                            const security = parts[3] || ""
                            if (seen.has(ssid)) {
                                if (inUse) {
                                    const existing = results.find(r => r.ssid === ssid)
                                    if (existing) existing.inUse = true
                                }
                                continue
                            }
                            seen.add(ssid)
                            results.push({ inUse, ssid, signal, security })
                        }
                        results.sort((a, b) => b.signal - a.signal)
                        contentRoot.networks = results
                    }
                }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 4

                RowLayout {
                    Text { 
                        text: "Wi-Fi Networks"
                        font.bold: true
                        font.pixelSize: 16
                        Layout.fillWidth: true
                        color: Theme.text 
                    }
                    Button {
                        id: reloadButton
                        hoverEnabled: true
                        text: "󰑓";
                        palette.buttonText: Theme.on_primary
                        onClicked: contentRoot.rescan()

                        background: Rectangle {
                            color: reloadButton.hovered ? Theme.primary_fixed_dim : Theme.primary_fixed
                            radius: 4
                        }

                        HoverHandler {
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }

                Text {
                    visible: contentRoot.errorText.length > 0
                    text: contentRoot.errorText
                    color: Theme.error
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    model: contentRoot.networks

                    delegate: Item {
                        required property var modelData
                        width: ListView.view.width

                        property bool connecting: modelData.ssid === contentRoot.connectingSSID
                        signal connectRequested(string ssid, string security)

                        implicitHeight: col.implicitHeight + 8

                        ColumnLayout {
                            id: col
                            width: parent.width
                            spacing: 4

                            RowLayout {
                                implicitWidth: parent.width

                                Text {
                                    text: root.wifiIcon(modelData.signal)
                                    color: modelData.inUse ? Theme.primary : Theme.text
                                    font.pixelSize: 20
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 0

                                    Text {
                                        text: modelData.ssid
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                        color: Theme.text
                                        font.bold: true
                                    }
                                    Text {
                                        text: modelData.security ? qsTr("Secured") + " - " + modelData.security : qsTr("Open network")
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                        color: Theme.text
                                        opacity: 0.7
                                        font.pixelSize: 11
                                    }
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
}
