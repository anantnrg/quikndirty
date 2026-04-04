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

    property color accent: "#eb6f92"

    property color color1: "#c4a7e7"
    property color color2: "#f6c177"
    property color color3: "#ebbcba"
    property color color4: "#31748f"
    property color color5: "#9ccfd8"

    property int radius: 20
    property int borderWidth: 12
    property int topbarHeight: 30
    property int sidebarWidth: 60

    // Multimedia configuration
    property var mprisRules: [
        {
            pattern: "^$",
            replace: "Nothing Playing"
        },
        {
            pattern: "Advertisement",
            replace: "Nothing Playing"
        },
        {
            pattern: " / X",
            replace: "Nothing Playing"
        },
        {
            pattern: "Reddit|r/",
            replace: "Nothing Playing"
        },
        {
            pattern: "YouTube",
            replace: "Nothing Playing"
        },
        {
            pattern: "Firefox",
            replace: "Nothing Playing"
        }
    ]

    property var trayIconOverrides: [
        {
            pattern: "discord|legcord|vesktop",
            icon: "",
            color: "#5865F2"
        },
        {
            pattern: "whatsapp|elecwhat|elec-what",
            icon: "",
            color: "#25D366"
        },
        {
            pattern: "spotify",
            icon: "",
            color: "#1DB954"
        },
        {
            pattern: "youtube",
            icon: "",
            color: "#FF0000"
        },
        {
            pattern: "steam",
            icon: "",
            color: "#1B2838"
        },
        {
            pattern: "nm-applet",
            icon: "",
            color: "#31748f"
        }
    ]
}
