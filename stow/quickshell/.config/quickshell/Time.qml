pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "hh:mm AP")
    }
    readonly property string date: {
        Qt.formatDateTime(clock.date, "dddd MMMM d yyyy")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}