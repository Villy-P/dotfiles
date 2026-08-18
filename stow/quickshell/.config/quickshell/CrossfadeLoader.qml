import QtQuick

Item {
    id: root
    property Component sourceComponent: null
    property int fadeDuration: 150

    property bool useA: true

    Loader {
        id: loaderA
        anchors.fill: parent
        opacity: root.useA ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: root.fadeDuration } }
        onOpacityChanged: if (opacity === 0) active = false
    }

    Loader {
        id: loaderB
        anchors.fill: parent
        opacity: root.useA ? 0 : 1
        Behavior on opacity { NumberAnimation { duration: root.fadeDuration } }
        onOpacityChanged: if (opacity === 0) active = false
    }

    onSourceComponentChanged: {
        if (!sourceComponent)
            return
        if (useA) {
            loaderB.active = true
            loaderB.sourceComponent = sourceComponent
        } else {
            loaderA.active = true
            loaderA.sourceComponent = sourceComponent
        }
        useA = !useA
    }
}
