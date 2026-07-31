pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    property FileView colorsFile: FileView {
        path: Quickshell.env("HOME") + "/.local/state/quickshell/generated/colors.json"
        watchChanges: true
        preload: true
        blockLoading: true
    }

    property var jsonData: JSON.parse(colorsFile.text())

    property color primary: jsonData.primary || "#000000"
    property color background: jsonData.background || "#000000"
    property color surface: jsonData.surface || "#111111"
    property color text: jsonData.text || "#ffffff"
}