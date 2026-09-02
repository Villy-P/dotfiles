import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import ".."
import "../components"

Rectangle {
    id: root
    implicitWidth: row.implicitWidth + 10
    implicitHeight: 35
    color: Theme.transparent
    radius: 6
    property var popupHost

    function prominentWindow(wsId) {
        let candidates = Hyprland.toplevels.values.filter(t => t.workspace?.id === wsId);
        if (candidates.length === 0) return null;

        candidates.sort((a, b) => {
            const ah = a.lastIpcObject?.focusHistoryID ?? 999;
            const bh = b.lastIpcObject?.focusHistoryID ?? 999;
            return ah - bh;
        });
        return candidates[0];
    }

    function getWorkspaceTitleIcon(wsId) {
        let prominent = prominentWindow(wsId);
        if (!prominent) return wsId;
        if (prominent.title.endsWith("Vivaldi")) return "";
        if (prominent.title.endsWith("Visual Studio Code")) return "";
        if (prominent.title.endsWith("Steam")) return "";
        if (prominent.title.includes("Obsidian")) return "";
        return "";
    }

    readonly property int currentWorkspace: Hyprland.focusedWorkspace?.id ?? 0

    RowLayout {
        id: row
        spacing: 4

        anchors.centerIn: parent

        Repeater {
            model: 5
            delegate: Rectangle {
                implicitWidth: 25
                implicitHeight: 25
                radius: 6
                color: currentWorkspace === (index + 1) ? Theme.primary : Theme.transparent

                StyledText {
                    anchors.centerIn: parent
                    text: getWorkspaceTitleIcon(index + 1)
                    font.pixelSize: 18
                    color: currentWorkspace === (index + 1) ? Theme.on_primary : Theme.text
                }
            }
        }
    }

    HoverHandler {
        id: iconHover
        cursorShape: Qt.PointingHandCursor
        onHoveredChanged: {
            if (iconHover.hovered) {
                root.popupHost.activate(root, workspaceContent, 700, 500)
            } else {
                root.popupHost.deactivate(root)
            }
        }
    }

    Component {
        id: workspaceContent
        Item {
            StyledText {
                text: "Workspace Settings"
            }
        }
    }
}