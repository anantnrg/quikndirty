import Quickshell
import QtQuick
import "components"

Scope {
    id: topBar
    
    readonly property string time: {
        Qt.formatDateTime(clock.date, "hh:mm:ss")
    }
    readonly property string date: {
        Qt.formatDateTime(clock.date, "yyyy-MM-dd")
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
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8
            
                    Text {
                        text: topBar.date
                        color: Config.accent
                        font.family: "JetBrains Mono"
                        font.weight: 800
                        font.pixelSize: 16
                    }
            
                    Text {
                        text: "•"
                        color: Config.textSecondary
                    }
            
                    Text {
                        text: "Extra"
                        color: Config.textPrimary
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
                        capsuleHeight: 36
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
