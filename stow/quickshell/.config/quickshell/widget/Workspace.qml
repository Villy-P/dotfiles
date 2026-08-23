import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import ".."
import "../components"

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight
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
        if (!prominent) return "";
        if (prominent.title.endsWith("Vivaldi")) return "";
        if (prominent.title.endsWith("Visual Studio Code")) return "";
        if (prominent.title.endsWith("Steam")) return "";
        return "";
    }

    readonly property int currentWorkspace: Hyprland.focusedWorkspace?.id ?? 0

    RowLayout {
        id: row
        spacing: 4
        Repeater {
            model: 5
            delegate: StyledText {
                text: getWorkspaceTitleIcon(index + 1)
                font.pixelSize: 16
                color: currentWorkspace === (index + 1) ? '#a9ecee' : '#007c98'
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