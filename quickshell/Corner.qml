pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "components"

Scope {
    id: cornerRoot

    required property int cornerType

    property int windowSize: 32
    property int visualSize: 24

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: win
            required property var modelData

            screen: modelData
            color: "transparent"

            readonly property bool isTop: cornerRoot.cornerType === RoundCorner.CornerEnum.TopLeft || cornerRoot.cornerType === RoundCorner.CornerEnum.TopRight
            readonly property bool isLeft: cornerRoot.cornerType === RoundCorner.CornerEnum.TopLeft || cornerRoot.cornerType === RoundCorner.CornerEnum.BottomLeft

            anchors {
                top: isTop
                bottom: !isTop

                left: isLeft
                right: !isLeft
            }

            implicitWidth: cornerRoot.windowSize
            implicitHeight: cornerRoot.windowSize

            RoundCorner {
                anchors.fill: parent
                implicitSize: cornerRoot.visualSize
                color: Config.bgPrimary
                corner: cornerRoot.cornerType
            }
        }
    }
}
