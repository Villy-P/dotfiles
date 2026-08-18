pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "dddd MMMM d hh:mm AP yyyy")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}