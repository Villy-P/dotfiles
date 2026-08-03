import QtQuick
import Quickshell
import ".."

PopupWindow {
    id: popup

    property Item anchorItem
    property bool hovering: false
    property int popupWidth: 400
    property int popupHeight: 300
    property int gap: 4
    property int closeDelay: 200
    property int expandDuration: 220
    property color backgroundColor: Qt.rgba(Theme.surface.r, Theme.surface.g, Theme.surface.b, 0.80)

    property real cornerRadius: 12
    property int padding: 8

    default property alias content: contentItem.data

    property bool windowVisible: false
    property bool expanded: false
    property bool cardHovered: false
    readonly property bool active: hovering || cardHovered

    implicitWidth: popupWidth
    implicitHeight: popupHeight
    color: "transparent"
    visible: windowVisible
    grabFocus: false

    anchor.item: anchorItem
    anchor.rect.x: 0
    anchor.rect.y: anchorItem ? anchorItem.height + gap : 0

    onActiveChanged: {
        if (active) {
            closeTimer.stop()
            hideTimer.stop()
            windowVisible = true
            expandTimer.restart()
        } else {
            closeTimer.restart()
        }
    }

    Timer {
        id: expandTimer
        interval: 1
        onTriggered: popup.expanded = true
    }

    Timer {
        id: closeTimer
        interval: popup.closeDelay
        onTriggered: {
            popup.expanded = false
            hideTimer.restart()
        }
    }

    Timer {
        id: hideTimer
        interval: popup.expandDuration
        onTriggered: popup.windowVisible = false
    }

    HoverHandler {
        onHoveredChanged: popup.cardHovered = hovered
    }

    Rectangle {
        id: card
        width: parent.width
        bottomRightRadius: popup.cornerRadius
        bottomLeftRadius: popup.cornerRadius
        clip: true
        transformOrigin: Item.Top
        color: popup.backgroundColor

        height: popup.expanded ? popup.popupHeight : 0
        scale: popup.expanded ? 1 : 0.92
        opacity: popup.expanded ? 1 : 0

        Behavior on height {
            NumberAnimation { duration: popup.expandDuration; easing.type: Easing.OutExpo }
        }

        Behavior on scale {
            NumberAnimation { duration: popup.expandDuration; easing.type: Easing.OutExpo }
        }

        Behavior on opacity {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }

        Item {
            id: contentItem
            anchors.fill: parent
            anchors.margins: popup.padding
        }
    }
}
