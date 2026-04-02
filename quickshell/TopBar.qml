pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "components"
import Quickshell.Services.Mpris

Scope {
    id: topBar

    readonly property string time: {
        Qt.formatDateTime(clock.date, "hh:mm:ss");
    }
    readonly property string date: {
        Qt.formatDateTime(clock.date, "yyyy-MM-dd");
    }

    // Media player
    readonly property MprisPlayer player: MprisController.activePlayer
    
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
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    Capsule {
                        side: Capsule.Side.Left
                        icon: "󰭧"
                        text: topBar.date
                        capsuleHeight: 32
                        padding: 16
                        accentColor: Config.color1
                        iconSize: 16
                    }
                    
                    Capsule {
                        side: Capsule.Side.Left
                        icon: "󰝚"
                        text: MprisController.track || "No music"
                        capsuleHeight: 32
                        padding: 16
                        accentColor: Config.color5
                        iconSize: 16
                    }
                }

                Row {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: "Center"
                        color: Config.textPrimary
                    }

                    Text {
                        text: "Stuff"
                        color: Config.textSecondary
                    }
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    Capsule {
                        side: Capsule.Side.Right
                        icon: ""
                        text: topBar.time
                        capsuleHeight: 32
                        padding: 16
                        accentColor: Config.color2
                        iconSize: 16
                    }
                }
            }
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
