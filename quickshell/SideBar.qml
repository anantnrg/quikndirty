pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Controls

Scope {
    id: sideBar

    Variants {
        model: Quickshell.screens

        PanelWindow {
            anchors {
                top: true
                bottom: true
                right: true 
            }
            
            id: sideBarWindow

            implicitWidth: 56
            color: Config.bgPrimary

            Item {
                anchors.fill: parent
                
                Column {
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 40 
                    
                    Text {
                        id: iconText
                        color: Config.accent
                        text: "󰣇"
                        font.family: "Symbols Nerd Font Mono"
                        font.pixelSize: 28
                        anchors.horizontalCenter: parent.horizontalCenter
                    
                        SequentialAnimation on color {
                            loops: Animation.Infinite
                    
                            ColorAnimation { to: Config.color1; duration: 4000 }
                            ColorAnimation { to: Config.color2; duration: 4000 }
                            ColorAnimation { to: Config.color3; duration: 4000 }
                            ColorAnimation { to: Config.color5; duration: 4000 }
                            ColorAnimation { to: Config.accent; duration: 4000 }
                        }
                    }
                    
                    SystemTray {
                        parentWindow: sideBarWindow
                    }
                }
                
                Column {
                    anchors.centerIn: parent
                    spacing: 24
                    
                    WorkspacesWidget {}
                }
                
                Column {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 16 
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 16
                    
                    Item {
                        id: bottomCapsule
                        width: 40
                        implicitHeight: networkText.implicitHeight + 16 + 16
                        
                        Rectangle {
                            id: background
                            anchors.fill: parent
                            color: Config.bgSecondary
                            radius: height / 2
                        }
                        
                        Text {
                            id: networkText
                            anchors.centerIn: parent
                            text: SysStats.net === 1 ? "" : "󰖪"
                            font.family: "Symbols Nerd Font Mono"
                            font.pointSize: 14
                            color: Config.textPrimary
                        }
                        
                        
                        Item {
                            id: root
                            width: 40
                            height: 40
                        
                            property int volume: 0
                            property bool muted: false
                            property bool hovered: false
                        
                            function icon() {
                                if (muted) return "󰖁"
                                if (volume > 66) return "󰕾"
                                if (volume > 33) return "󰖀"
                                if (volume > 0) return "󰕿"
                                return "󰖁"
                            }
                        
                            Rectangle {
                                anchors.fill: parent
                                color: Config.bgSecondary
                                radius: height / 2
                            }
                        
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                        
                                onEntered: root.hovered = true
                                onExited: root.hovered = false
                            }
                        
                            Rectangle {
                                anchors.fill: parent
                                radius: 6
                                color: Config.accent
                                opacity: root.hovered ? 0.2 : 0
                            }
                        
                            Text {
                                anchors.centerIn: parent
                                text: root.icon()
                                font.family: "Symbols Nerd Font Mono"
                                font.pixelSize: 18
                                color: Config.color4
                            }
                        
                            Rectangle {
                                width: 120
                                height: 40
                                radius: 10
                                color: Config.bgSecondary
                        
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.left
                                anchors.rightMargin: root.hovered ? 8 : -120
                        
                                opacity: root.hovered ? 1 : 0
                        
                                Behavior on anchors.rightMargin {
                                    NumberAnimation { duration: 180; easing.type: Easing.InOutCubic }
                                }
                        
                                Behavior on opacity {
                                    NumberAnimation { duration: 120 }
                                }
                        
                                Slider {
                                    anchors.centerIn: parent
                                    width: 90
                                    from: 0
                                    to: 100
                                    value: root.volume
                        
                                    onMoved: (v) => {
                                        Qt.openUrlExternally("bash -c 'pactl set-sink-volume @DEFAULT_SINK@ " + Math.round(v) + "%'")
                                    }
                                }
                            }
                        
                            WheelHandler {
                                onWheel: (e) => {
                                    if (e.angleDelta.y > 0)
                                        Qt.openUrlExternally("bash -c 'pactl set-sink-volume @DEFAULT_SINK@ +5%'")
                                    else
                                        Qt.openUrlExternally("bash -c 'pactl set-sink-volume @DEFAULT_SINK@ -5%'")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}