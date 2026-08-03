import Quickshell
import QtQuick

import "./widget" as Widget

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
                color: Qt.rgba(
                    Theme.surface.r,
                    Theme.surface.g,
                    Theme.surface.b,
                    0.80
                )
                radius: 12

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    Widget.ArchLogo {}
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    Widget.Clock {}
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    Widget.Wifi {}
                }
            }
        }
    }
}