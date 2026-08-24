import QtQuick
import Quickshell
import ".."

PopupWindow {
    id: popup

    property int gap: 0
    property int animDuration: 220
    property int minCardWidth: 260
    property int maxCardHeight: 800
    property var popupHost

    implicitWidth: popupHost.barRoot ? popupHost.barRoot.width : 500
    implicitHeight: maxCardHeight
    color: "transparent"
    visible: popupHost.activeTrigger !== null
    grabFocus: false

    anchor.item: popupHost.barRoot
    anchor.rect.x: 0
    anchor.rect.y: popupHost.barRoot ? popupHost.barRoot.height + gap : 0

    Rectangle {
        id: card
        clip: true
        color: Qt.rgba(Theme.surface.r, Theme.surface.g, Theme.surface.b, 0.80)

        readonly property real targetWidth: Math.max(popupHost.triggerWidth, popupHost.contentWidth)

        width: targetWidth
        height: popup.visible ? popupHost.contentHeight : 0
        x: Math.max(0, Math.min(popupHost.triggerX, popup.implicitWidth - targetWidth))

        Behavior on x {
            NumberAnimation {
                duration: popup.animDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: [0.05, 0.7, 0.1, 1.0, 1, 1]
            }
        }
        Behavior on width {
            NumberAnimation {
                duration: popup.animDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: [0.05, 0.7, 0.1, 1.0, 1, 1]
            }
        }
        Behavior on height {
            NumberAnimation {
                duration: popup.animDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: [0.05, 0.7, 0.1, 1.0, 1, 1]
            }
        }

        HoverHandler {
            onHoveredChanged: {
                if (!popupHost) return
                if (hovered)
                    popupHost.keepOpen()
                else
                    popupHost.deactivate(popupHost.activeTrigger)
            }
        }

        CrossfadeLoader {
            anchors.fill: parent
            anchors.margins: 8
            sourceComponent: popupHost.activeContent
        }
    }
}
