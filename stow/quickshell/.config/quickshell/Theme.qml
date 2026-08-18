pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property FileView colorsFile: FileView {
        path: Quickshell.env("HOME") + "/.local/state/quickshell/generated/colors.json"
        watchChanges: true
        preload: true
        blockLoading: true

        onFileChanged: reload()

        onLoaded: root.jsonData = JSON.parse(text() || "{}")
    }

    property var jsonData: ({})

    property string family: "CaskaydiaCove NF"

    property color primary: jsonData.primary || "#000000"
    property color primary_container: jsonData.primary_container || "#111111"
    property color primary_fixed: jsonData.primary_fixed || "#222222"
    property color primary_fixed_dim: jsonData.primary_fixed_dim || "#333333"
    property color background: jsonData.background || "#000000"
    property color surface: jsonData.surface || "#111111"
    property color text: jsonData.text || "#ffffff"
    property color inverse_primary: jsonData.inverse_primary || "#ffffff"
}