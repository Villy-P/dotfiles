import QtQuick
import QtQuick.Layouts
import ".."
import "../components"

Rectangle {
    property int horizontalPadding: 10
    implicitWidth: col.implicitWidth + horizontalPadding * 2
    implicitHeight: 35
    color: Theme.transparent
    radius: 6

    ColumnLayout {
        id: col
        anchors.centerIn: parent
        spacing: 0

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 5

            StyledText {
                text: ""
                color: "#ee729d"
                font.pixelSize: 16
            }

            StyledText {
                text: Time.time
                font.pixelSize: 16
                font.weight: Font.Medium
            }
        }

        StyledText {
            Layout.alignment: Qt.AlignHCenter
            text: Time.date
            font.pixelSize: 11
            color: Theme.textSecondary ?? "#9a9a9a"
        }
    }
}