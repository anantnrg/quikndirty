import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: sideBar
    property string time

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

    Process {
        id: dateProc
        command: ["date"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: sideBar.time = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
