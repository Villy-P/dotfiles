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

    property int volume: 0

    function volumeIcon(volume) {
        if (volume == 0) return "󰖁"
        if (volume < 30) return "󰕿"
        if (volume < 70) return "󰖀"
        return "󰕾"
    }

    Process {
        id: audioProcess
        command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/Volume: //'"]
        stdout: SplitParser {
            onRead: data => {
                root.volume = Math.round(parseFloat(data) * 100) || 0;
            }
        }
    }

    Process {
        id: audioWatcher
        command: ["sh", "-c", "pactl subscribe"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                if (line.includes("sink") || line.includes("server")) {
                    audioProcess.running = true
                }
            }
        }
    }

    Component.onCompleted: audioProcess.running = true

    RowLayout {
        id: row
        spacing: 4
        Text { 
            text: root.volumeIcon(root.volume)
            font.pixelSize: 16
            color: Theme.text
        }
        Text { 
            text: root.volume + "%"
            color: Theme.text
        }
    }

    HoverHandler {
        id: iconHover
        cursorShape: Qt.PointingHandCursor
    }

    AnimatedPopup {
        id: popup
        anchorItem: root
        hovering: iconHover.hovered
        popupWidth: 400
        popupHeight: 300
    }
}
