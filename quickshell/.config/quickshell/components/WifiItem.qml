import QtQuick
import Quickshell.Io
import QtQuick.Controls
import QtQuick.Layouts
import ".."

Item {
    required property var modelData
    required property var contentRoot
    property bool showPassword: false
    width: ListView.view.width

    property bool connecting: modelData.ssid === contentRoot.connectingSSID
    signal connectRequested(string ssid, string security)

    implicitHeight: col.implicitHeight + 8

    Process {
        id: copyPasswordProcess
        command: ["sh", "-c", "echo -n '" + contentRoot.password + "' | wl-copy"]
    }

    ColumnLayout {
        id: col
        width: parent.width
        spacing: 4

        RowLayout {
            width: parent.width

            Text {
                text: root.wifiIcon(modelData.signal)
                color: modelData.inUse ? Theme.primary : Theme.text
                font.pixelSize: 20
                font.family: Theme.family
            }

            GridLayout {
                Layout.fillWidth: true
                columns: 2
                columnSpacing: 0
                rowSpacing: 0

                Text {
                    text: modelData.ssid
                    Layout.fillWidth: true
                    font.bold: true
                    color: Theme.text
                    elide: Text.ElideRight
                    font.family: Theme.family
                }

                Text {
                    text: modelData.band
                    color: Theme.text
                    Layout.alignment: Qt.AlignRight
                    horizontalAlignment: Text.AlignRight
                    font.family: Theme.family
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 4

                    Text {
                        text: modelData.security
                            ? qsTr("Secured") + " - " + modelData.security
                            : qsTr("Open network")
                        elide: Text.ElideRight
                        color: Theme.text
                        opacity: 0.7
                        font.pixelSize: 11
                        visible: !showPassword
                        font.family: Theme.family
                    }

                    Text {
                        text: contentRoot.password
                        elide: Text.ElideRight
                        color: Theme.text
                        opacity: 0.7
                        font.pixelSize: 11
                        visible: showPassword
                        font.family: Theme.family

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onClicked: {
                                copyPasswordProcess.running = true
                            }
                        }
                    }

                    Text {
                        id: eyeIcon
                        visible: modelData.inUse
                        text: showPassword ? "󰈉" : "󰈈"
                        color: Theme.text
                        opacity: 0.7
                        font.family: Theme.family
                        font.pixelSize: 12

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onClicked: showPassword = !showPassword
                        }
                    }
                }

                Text {
                    text: modelData.signal + "%"
                    Layout.alignment: Qt.AlignRight
                    horizontalAlignment: Text.AlignRight
                    opacity: 0.7
                    color: Theme.text
                    font.pixelSize: 11
                    font.family: Theme.family
                }
            }
        }
    }
}