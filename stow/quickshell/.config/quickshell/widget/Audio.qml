import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import ".."
import "../components"

Item {
    id: root
    implicitWidth: outputRect.implicitWidth + inputRect.implicitWidth + 10
    implicitHeight: Math.max(outputRect.implicitHeight, inputRect.implicitHeight)

    property var popupHost

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property var source: Pipewire.defaultAudioSource

    readonly property int volume: sink?.audio ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property int inputVolume: source?.audio ? Math.round(source.audio.volume * 100) : 0
    readonly property bool inputMuted: source?.audio?.muted ?? false

    PwObjectTracker {
        objects: [root.sink, root.source]
    }

    function volumeIcon() {
        if (root.sink.description.includes("earbuds")) {
            if (root.muted || root.volume === 0) return "󱡐"
            return "󱡏"
        } else {
            if (root.muted || root.volume === 0) return "󰖁"
            if (root.volume < 30) return "󰕿"
            if (root.volume < 70) return "󰖀"
            return "󰕾"
        }
    }

    function inputVolumeIcon() {
        return root.inputMuted || root.inputVolume === 0 ? "󰍭" : "󰍬"
    }

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        Rectangle {
            id: outputRect
            color: Theme.tertiary_container
            implicitWidth: row.implicitWidth + 10
            implicitHeight: 25
            radius: 6

            RowLayout {
                id: row
                spacing: 4
                anchors.centerIn: parent

                StyledText {
                    text: root.volumeIcon()
                    font.pixelSize: 16
                    color: Theme.on_tertiary_container
                }

                StyledText {
                    color: Theme.on_tertiary_container
                    text: root.sink.description + " (" + (root.muted ? "Muted" : root.volume + "%") + ")"
                }
            }
        }

        Rectangle {
            id: inputRect
            color: Theme.tertiary_container
            implicitWidth: input_row.implicitWidth + 10
            implicitHeight: 25
            radius: 6

            RowLayout {
                id: input_row
                spacing: 4
                anchors.centerIn: parent

                StyledText {
                    text: root.inputVolumeIcon()
                    font.pixelSize: 16
                    color: Theme.on_tertiary_container
                }

                StyledText {
                    color: Theme.on_tertiary_container
                    text: root.source.description + " (" + (root.inputMuted ? "Muted" : root.inputVolume + "%") + ")"
                }
            }
        }
    }
}