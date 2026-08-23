import QtQuick
import ".."
import "../components"

Rectangle {
    id: root
    color: Theme.transparent
    radius: 6
    implicitWidth: 35
    implicitHeight: 35

    StyledText {
        anchors.centerIn: parent
        text: "󰣇"
        color: "#168eca"
        font.pixelSize: 24
    }
}