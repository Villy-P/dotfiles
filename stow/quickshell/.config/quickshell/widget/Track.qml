import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Bluetooth
import Quickshell.Widgets
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell.Io
import ".."
import "../components"


Rectangle {
    id: root
    implicitWidth: row.implicitWidth + 10
    implicitHeight: 35
    color: Theme.transparent
    radius: 6

    visible: Mpris.players.values.length > 0 && activePlayer.length !== 0

    readonly property bool isPlaying: activePlayer.isPlaying
    readonly property MprisPlayer activePlayer: Mpris.players.values[0] ?? null

    function formatTime(sec) {
        if (isNaN(sec) || sec <= 0) return "00:00";
        let m = Math.floor(sec / 60);
        let s = Math.floor(sec % 60);
        return (m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s;
    }

    Timer {
        interval: 1000
        running: activePlayer?.playbackState === MprisPlaybackState.Playing
        repeat: true
        onTriggered: activePlayer?.positionChanged()
    }

    RowLayout {
        id: row
        spacing: 4
        anchors.centerIn: parent

        ClippingRectangle {
            width: 30
            height: 30
            radius: 6

            Image {
                anchors.fill: parent
                source: activePlayer?.trackArtUrl ?? ""
                fillMode: Image.PreserveAspectCrop
                smooth: true
            }
        }

        ColumnLayout {
            id: col
            spacing: 0
        
            StyledText {
                text: activePlayer.trackTitle
                font.pixelSize: 14
            }

            StyledText {
                text: activePlayer.trackArtist + " - " + (formatTime(activePlayer.position) + " / " + formatTime(activePlayer.length))
                font.pixelSize: 10
                color: Theme.text_dim
            }
        }

        RowLayout {
            spacing: -4

            Button {
                hoverEnabled: true
                contentItem: StyledText {
                    anchors.centerIn: parent
                    text: ""
                    font.family: Theme.family
                    font.pixelSize: 24
                    color: Theme.text
                }
                onClicked: {
                    activePlayer.previous()
                }

                flat: true
                background: Item {}

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Button {
                hoverEnabled: true
                contentItem: StyledText {
                    anchors.centerIn: parent
                    text: isPlaying ? "󰏤" : ""
                    font.family: Theme.family
                    font.pixelSize: 24
                    color: Theme.text
                }
                onClicked: {
                    if (isPlaying) {
                        activePlayer.pause()
                    } else {
                        activePlayer.play()
                    }
                }

                flat: true
                background: Item {}

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Button {
                hoverEnabled: true
                contentItem: StyledText {
                    anchors.centerIn: parent
                    text: ""
                    font.family: Theme.family
                    font.pixelSize: 24
                    color: Theme.text
                }
                onClicked: activePlayer.next()

                flat: true
                background: Item {}

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }

    }
}