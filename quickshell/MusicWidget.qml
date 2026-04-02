import QtQuick

Item {
    id: root

    property var player: MprisController.activePlayer
    property string track: MprisController.track
    property bool isPlaying: MprisController.isPlaying

    property int widgetHeight: 32
    property int accentWidth: 36
    property int maxTextWidth: 320

    implicitHeight: widgetHeight
    implicitWidth: accent.width + textBox.width

    Row {
        anchors.centerIn: parent
        spacing: 0

        Rectangle {
            id: accent
            width: root.accentWidth
            height: root.widgetHeight
            color: Config.color5

            radius: root.widgetHeight / 2
            topRightRadius: 0
            bottomRightRadius: 0

            Text {
                anchors.centerIn: parent
                text: "󰝚"
                color: Config.bgPrimary
                font.family: "Symbols Nerd Font Mono"
                font.pixelSize: 16
            }
        }

        Rectangle {
            id: textBox
            height: root.widgetHeight
            width: Math.min(text1.implicitWidth + 32, root.maxTextWidth + 32)

            color: Config.bgPrimary
            border.color: Config.color5
            border.width: 2

            radius: root.widgetHeight / 2
            topLeftRadius: 0
            bottomLeftRadius: 0

            clip: true

            Item {
                id: scrollRoot
                anchors.fill: parent
                anchors.margins: 16

                property int gap: 40
                property bool overflowing: text1.width > root.maxTextWidth

                Item {
                    id: content
                    height: parent.height
                    implicitWidth: text1.implicitWidth + scrollRoot.gap + text2.implicitWidth

                    Text {
                        id: text1
                        text: root.track || "No music"
                        color: Config.color5
                        font.family: "JetBrains Mono"
                        font.pixelSize: 14
                        font.weight: 700
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        id: text2
                        text: text1.text
                        color: Config.color5
                        font.family: text1.font.family
                        font.pixelSize: text1.font.pixelSize
                        font.weight: text1.font.weight

                        anchors.verticalCenter: parent.verticalCenter
                        x: text1.width + scrollRoot.gap
                    }
                }

                SequentialAnimation {
                    running: scrollRoot.overflowing
                    loops: Animation.Infinite

                    PauseAnimation {
                        duration: 2000
                    }

                    NumberAnimation {
                        target: content
                        property: "x"
                        from: 0
                        to: -(text1.width + scrollRoot.gap)
                        duration: (text1.width * 250) / 40
                        easing.type: Easing.InOutSine
                    }

                    PauseAnimation {
                        duration: 800
                    }
                }

                Rectangle {
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    visible: scrollRoot.overflowing
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: Config.bgPrimary
                        }
                        GradientStop {
                            position: 1
                            color: "transparent"
                        }
                    }
                }

                Rectangle {
                    anchors.right: parent.right
                    width: 20
                    height: parent.height
                    visible: scrollRoot.overflowing
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "transparent"
                        }
                        GradientStop {
                            position: 1
                            color: Config.bgPrimary
                        }
                    }
                }
            }
        }
    }

    Connections {
        target: root.player

        function onMetadataChanged() {
            content.x = 0;
        }

        function onPlaybackStateChanged() {
            content.x = 0;
        }
    }
}
