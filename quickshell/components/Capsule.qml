import QtQuick
import ".."

Item {
    id: root

    enum Side {
        Left,
        Right
    }

    property int side: Capsule.Side.Left

    property string text: ""
    property string icon: ""

    property color accentColor: Config.accent
    property color bgColor: Config.bgPrimary

    property int capsuleHeight: 24
    property int padding: 20
    property int spacing: 6
    property int accentWidth: 36
    property int fontSize: 14

    implicitHeight: capsuleHeight
    implicitWidth: row.implicitWidth

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 0

        Rectangle {
            visible: root.side === Capsule.Side.Left
            height: root.capsuleHeight
            width: root.accentWidth
            color: root.accentColor

            radius: root.capsuleHeight / 2
            topRightRadius: 0
            bottomRightRadius: 0

            Text {
                anchors.centerIn: parent
                text: root.icon
                color: root.bgColor
                font.family: "Symbols Nerd Font Mono"
                font.pixelSize: root.fontSize 
            }
        }

        Rectangle {
            height: root.capsuleHeight
            width: textRow.width + root.padding * 2
            color: root.bgColor

            border.color: root.accentColor
            border.width: 2

            topLeftRadius: root.side === Capsule.Side.Right ? root.capsuleHeight / 2 : 0
            topRightRadius: root.side === Capsule.Side.Left ? root.capsuleHeight / 2 : 0
            bottomLeftRadius: root.side === Capsule.Side.Right ? root.capsuleHeight / 2 : 0
            bottomRightRadius: root.side === Capsule.Side.Left ? root.capsuleHeight / 2 : 0
            
            Row {
                id: textRow
                anchors.centerIn: parent
                spacing: root.spacing

                Text {
                    text: root.text
                    color: root.accentColor
                    font.family: "JetBrains Mono"
                    font.weight: 700
                    font.pixelSize: root.fontSize 
                }
            }
        }

        Rectangle {
            visible: root.side === Capsule.Side.Right
            height: root.capsuleHeight
            width: root.accentWidth
            color: root.accentColor

            radius: root.capsuleHeight / 2
            topLeftRadius: 0
            bottomLeftRadius: 0

            Text {
                anchors.centerIn: parent
                text: root.icon
                color: root.bgColor
                font.family: "Symbols Nerd Font Mono"
                font.pixelSize: root.fontSize + 2 
            }
        }
    }
}