pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    property int focusedWorkspaceId: Hyprland.focusedWorkspace?.id ?? 1
    property int totalWorkspaces: 9

    id: root 
    width: 40
    height: workspaceColumn.implicitHeight + 20 + 20
   
    Rectangle {
        id: background
        anchors.fill: parent
        color: Config.bgSecondary
        radius: height / 2
    }
    
    Column {
        id: workspaceColumn
        spacing: 20
        anchors.centerIn: parent
       
        anchors.topMargin: 20
        anchors.bottomMargin: 20
        
        Repeater {
            model: root.totalWorkspaces

            Rectangle {
                required property int index
                
                width: 10
                height: index + 1 === root.focusedWorkspaceId ? 32 : 10
                radius: width
                color: Config.accent 
                anchors.horizontalCenter: parent.horizontalCenter
                
                opacity: index + 1 === root.focusedWorkspaceId ? 1 : 0.32
                
                Behavior on height {
                    NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Hyprland.dispatch(`workspace ${index + 1}`);
                        root.focusedWorkspaceId = index + 1;
                    }
                }
            }
        }
    }

    Connections {
        target: Hyprland
        function onFocusedWorkspaceChanged() {
            root.focusedWorkspaceId = Hyprland.focusedWorkspace?.id ?? 1;
        }
    }
}