import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell.Io
import ".."
import "../components"

pragma ComponentBehavior: Bound

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

    Rectangle {
        color: Theme.primary
        implicitWidth: row.implicitWidth + 10
        implicitHeight: 25
        radius: 6
        anchors.centerIn: parent

        RowLayout {
            anchors.centerIn: parent
            id: row
            spacing: 4
            
            StyledText { 
                text: root.wifiIcon(root.signalStrength)
                font.pixelSize: 16
                color: Theme.on_primary
            }
            StyledText { 
                visible: root.connected
                text: root.ssid + " (" + root.signalStrength + "%)"
                color: Theme.on_primary
            }
        }
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
            property var currentNetwork: null
            property string connectingSSID: ""
            property string errorText: ""
            property int page: 0

            Component.onCompleted: rescan()

            function rescan() {
                errorText = ""
                scanProcess.running = true
                passwordProcess.running = true
            }

            property string password: ""

            Process {
                id: passwordProcess
                command: ["sh", "-c", "nmcli device wifi show-password | awk -F': ' '/Password/ {print $2}'"]
                stdout: StdioCollector {
                    onStreamFinished: {
                        password = text.trim()
                    }
                }
            }

            Process {
                id: scanProcess
                command: [
                    "sh", "-c",
                    "nmcli dev wifi rescan 2>/dev/null; sleep 1; nmcli -t -f in-use,ssid,signal,security,band dev wifi list"]
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
                            const band = parts[4] || ""
                            if (seen.has(ssid)) {
                                if (inUse) {
                                    const existing = results.find(r => r.ssid === ssid)
                                    if (existing) existing.inUse = true
                                }
                                continue
                            }
                            seen.add(ssid)
                            results.push({ inUse, ssid, signal, security, band })
                        }
                        results.sort((a, b) => b.signal - a.signal)
                        contentRoot.currentNetwork = results.splice(results.findIndex(n => n.inUse), 1)[0] || null
                        contentRoot.networks = results
                    }
                }
            }

            CrossfadeLoader {
                anchors.fill: parent
                sourceComponent: contentRoot.page === 0 ? wifiListView : wifiPasswordView
            }

            Component {
                id: wifiListView

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 4

                    RowLayout {
                        StyledText { 
                            text: "Wi-Fi"
                            font.bold: true
                            font.pixelSize: 16
                            Layout.fillWidth: true
                        }
                        Button {
                            id: reloadButton
                            hoverEnabled: true
                            text: "󰑓";
                            font.family: Theme.family
                            palette.buttonText: Theme.on_primary
                            onClicked: { 
                                passwordProcess.running = true
                                contentRoot.page = 1
                            }

                            background: Rectangle {
                                color: reloadButton.hovered ? Theme.primary_fixed_dim : Theme.primary_fixed
                                radius: 4
                            }

                            HoverHandler {
                                cursorShape: Qt.PointingHandCursor
                            }
                        }
                    }
                    
                    WifiItem {
                        visible: contentRoot.currentNetwork !== null
                        Layout.fillWidth: true

                        modelData: contentRoot.currentNetwork
                        contentRoot: contentRoot
                    }


                    StyledText {
                        text: scanProcess.running ? "Scanning..." : (contentRoot.errorText.length > 0 ? contentRoot.errorText : (contentRoot.networks.length === 0 ? "No networks found" : "Networks"))
                    }

                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        model: contentRoot.networks

                        delegate: WifiItem {
                            contentRoot: contentRoot
                        }
                    }
                }
            }

            Component {
                id: wifiPasswordView

                Item {
                    anchors.fill: parent

                    StyledText {
                        text: passwordProcess.running ? "Loading..." : (contentRoot.password.length > 0 ? contentRoot.password : "No password available")
                    }
                }
            }
        }
    }
}
