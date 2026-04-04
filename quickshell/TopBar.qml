pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import "components"
import Quickshell.Services.Mpris

Scope {
    id: topBar

    readonly property string time: {
        Qt.formatDateTime(clock.date, "hh:mm:ss");
    }
    readonly property string date: {
        Qt.formatDateTime(clock.date, "dddd, yyyy-MM-dd");
    }

    // Media player
    readonly property MprisPlayer player: MprisController.activePlayer

    // Stats
    property int cpu: 0
    property int ram: 0
    property int temp: 0

    function pad2(n) {
        return n < 10 ? " " + n : n;
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 50

            color: Config.bgPrimary

            Item {
                anchors.fill: parent

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 24
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 16

                    Capsule {
                        side: Capsule.Side.Left
                        icon: "󰭧"
                        text: topBar.date
                        capsuleHeight: 32
                        padding: 16
                        accentColor: Config.color1
                        iconSize: 16
                    }

                    MusicWidget {
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Row {
                    anchors.centerIn: parent
                    spacing: 8

                    ActiveWindow {}
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 24
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 16

                    Capsule {
                        side: Capsule.Side.Right
                        icon: ""
                        text: topBar.cpu + "%"
                        capsuleHeight: 32
                        padding: 16
                        accentColor: Config.color5
                        iconSize: 16
                        widthSample: "00%"
                    }

                    Capsule {
                        side: Capsule.Side.Right
                        icon: ""
                        text: topBar.pad2(topBar.ram) + "%"
                        capsuleHeight: 32
                        padding: 16
                        accentColor: Config.color3
                        iconSize: 16
                        widthSample: "00%"
                    }

                    Capsule {
                        side: Capsule.Side.Right
                        icon: ""
                        text: topBar.pad2(topBar.temp) + "°C"
                        capsuleHeight: 32
                        padding: 16
                        accentColor: Config.color2
                        iconSize: 16
                        widthSample: "00°C"
                    }

                    Capsule {
                        side: Capsule.Side.Right
                        icon: ""
                        text: topBar.time
                        capsuleHeight: 32
                        padding: 16
                        accentColor: Config.color1
                        iconSize: 16
                        widthSample: " 00:00:00 "
                    }
                }
            }
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Process {
        id: statsProc
        command: ["bash", "-c", "~/.config/quickshell/sysstat.sh"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    let data = JSON.parse(this.text);

                    topBar.cpu = data.cpu;
                    topBar.ram = data.ram;
                    topBar.temp = data.temp;
                } catch (e) {
                    console.log("JSON parse failed:", this.text);
                }
            }
        }
    }

    Timer {
        interval: 1024
        running: true
        repeat: true
        onTriggered: statsProc.running = true
    }
}
