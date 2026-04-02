import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: sideBar

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                bottom: true
                right: true
            }

            implicitWidth: 64
            color: Config.bgPrimary

            Text {
                text: "fucking test innit"
            }
        }
    }
}
