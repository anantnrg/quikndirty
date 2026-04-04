pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick

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

            implicitWidth: 64
            color: Config.bgPrimary

            Item {
                anchors.fill: parent
                
                Column {
                    anchors.top: parent.top
                    anchors.topMargin: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 16
                    
                    Text {
                        id: iconText
                        color: Config.accent
                        text: "󰣇"
                        font.family: "Symbols Nerd Font Mono"
                        font.pixelSize: 32
                    
                        SequentialAnimation on color {
                            loops: Animation.Infinite
                    
                            ColorAnimation { to: Config.color1; duration: 4000 }
                            ColorAnimation { to: Config.color2; duration: 4000 }
                            ColorAnimation { to: Config.color3; duration: 4000 }
                            ColorAnimation { to: Config.color5; duration: 4000 }
                            ColorAnimation { to: Config.accent; duration: 4000 }
                        }
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
                   
                    SystemTray {
                        parentWindow: sideBarWindow
                    }
                }
            }
        }
    }
}