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

            implicitWidth: 60

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
            onStreamFinished: topBar.time = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
