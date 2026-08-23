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
    property color secondary: jsonData.secondary || "#000000"
    property color secondary_container: jsonData.secondary_container || "#111111"
    property color tertiary: jsonData.tertiary || "#000000"
    property color tertiary_container: jsonData.tertiary_container || "#111111"
    property color background: jsonData.background || "#000000"
    property color surface: jsonData.surface || "#111111"
    property color on_surface: jsonData.on_surface || "#000000"
    property color text: jsonData.text || "#ffffff"
    property color inverse_primary: jsonData.inverse_primary || "#ffffff"
    property color on_primary: jsonData.on_primary || "#ffffff"
    property color on_secondary: jsonData.on_secondary || "#ffffff"
    property color on_tertiary: jsonData.on_tertiary || "#ffffff"
    property color on_primary_container: jsonData.on_primary_container || "#ffffff"
    property color on_secondary_container: jsonData.on_secondary_container || "#ffffff"
    property color on_tertiary_container: jsonData.on_tertiary_container || "#ffffff"

    property color transparent: Qt.rgba(
        surface.r,
        surface.g,
        surface.b,
        0.6
    )
}