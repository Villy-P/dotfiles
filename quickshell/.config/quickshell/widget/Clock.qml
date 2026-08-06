import QtQuick
import QtQuick.Layouts
import ".."
import "../components"

RowLayout {
    StyledText {
        text: " "
        color: "#ee729d"
    }

    StyledText {
        text: Time.time
    }
}
