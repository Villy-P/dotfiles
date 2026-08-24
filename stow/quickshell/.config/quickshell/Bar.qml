import Quickshell
import QtQuick
import QtQuick.Layouts
import "./Theme"

import "./widget" as RiceWidget

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

            implicitHeight: 40
            color: "transparent"

            margins {
                top: 8
                left: 8
                right: 8
                bottom: -8
            }

            QtObject {
                id: popupHost

                property Item barRoot: barRow
                property Item activeTrigger: null
                property Component activeContent: null

                property real triggerX: 0
                property real triggerWidth: 0
                property real contentWidth: 400
                property real contentHeight: 300

                property int closeDelay: 200

                function keepOpen() {
                    closeTimer.stop()
                }

                function activate(trigger, content, width, height) {
                    closeTimer.stop()
                    activeTrigger = trigger
                    activeContent = content
                    contentWidth = width || 400
                    contentHeight = height || 300
                    updateGeometry()
                }

                function deactivate(trigger) {
                    if (activeTrigger === trigger)
                        closeTimer.restart()
                }

                function updateGeometry() {
                    if (!activeTrigger || !barRoot)
                        return
                    const pos = activeTrigger.mapToItem(barRoot, 0, 0)
                    triggerX = pos.x
                    triggerWidth = activeTrigger.width
                }

                property Timer closeTimer: Timer {
                    interval: popupHost.closeDelay
                    onTriggered: {
                        popupHost.activeTrigger = null
                        popupHost.activeContent = null
                    }
                }
            }

            MorphingPopup {
                popupHost: popupHost
            }

            Rectangle {
                id: barRow
                anchors.fill: parent
                color: "transparent"
                radius: 12

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    RiceWidget.ArchLogo {}
                    RiceWidget.Workspace { popupHost: popupHost }
                    RiceWidget.Track {}
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    RiceWidget.Clock {}
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    Rectangle {
                        id: sysTray
                        implicitWidth: sysRow.implicitWidth + 20
                        implicitHeight: 35
                        color: Theme.transparent
                        radius: 6

                        RowLayout {
                            id: sysRow
                            anchors.centerIn: parent
                            spacing: 8

                            RiceWidget.USB { }
                            RiceWidget.Wifi { popupHost: popupHost }
                            RiceWidget.Bluetooth { }
                            RiceWidget.Audio { popupHost: popupHost }
                            RiceWidget.Power { popupHost: popupHost }
                        }
                    }
                }
            }
        }
    }
}