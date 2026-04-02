// Config.qml
pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: config

    property color bgPrimary: "#191724"
    property color bgSecondary: "#1f1d2e"
    property color surface: "#26233a"

    property color textPrimary: "#e0def4"
    property color textSecondary: "#6e6a86"

    property color accent: "#c4a7e7"
    
    
    property color color1: "#eb6f92"
    property color color2: "#f6c177"
    property color color3: "#ebbcba"
    property color color4: "#31748f"
    property color color5: "#9ccfd8"

    property int radius: 20
    property int borderWidth: 12
    property int topbarHeight: 30
    property int sidebarWidth: 60
}
