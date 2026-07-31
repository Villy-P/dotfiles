import Quickshell
import Quickshell.Hyprland
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            id: panelWindow

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30
            color: "transparent"

            margins {
                top: 8
                left: 8
                right: 8
            }

            Rectangle {
                anchors.fill: parent
                color: Theme.background
                radius: 12

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    // property var workspaceIds: Hyprland.workspaces.values
                    //     .map(w => w.id)
                    //     .filter(id => id > 0)
                    //     .sort((a, b) => a - b);

                    Text {
                        text: "󰣇"
                        color: Theme.text
                        font.pixelSize: 16
                    }

                    // Repeater {
                    //     model: Hyprland.workspaces.values.length + 1

                    //     Rectangle {
                    //         property int wsId: index + 1
                    //         property bool isActive: Hyprland.focusedWorkspace.id === wsId
                    //         property bool exists: Hyprland.workspaces.some(w => w.id === wsId)
                    //         property bool isFinal: wsId === Hyprland.workspaces.values.length + 1

                    //         width: 20
                    //         height: 20
                    //         radius: 4
                    //         color: isActive ? "#89b4fa" : (exists ? "#45475a" : "transparent")
                    //         border.width: exists ? 0 : 1
                    //         border.color: "#45475a"

                    //         Text {
                    //             anchors.centerIn: parent
                    //             text: parent.isFinal ? "+" : parent.wsId
                    //             color: parent.isActive ? "#1e1e2e" : (parent.exists ? "#cdd6f4" : "#6c7086")
                    //             font.pixelSize: 12
                    //         }

                    //         MouseArea {
                    //             anchors.fill: parent
                    //             onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${parent.isFinal ? Hyprland.workspaces.values.length + 1 : parent.wsId} })`)
                    //         }
                    //     }
                    // }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    ClockWidget {}
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8
                }
            }
        }
    }
}