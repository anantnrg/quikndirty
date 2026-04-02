import Quickshell
import QtQuick
import "components"

Scope {
    id: brCorner

    Variants {
        model: Quickshell.screens

        PanelWindow {
            anchors {
                bottom: true
                right: true
            }

            color: "transparent"

            implicitWidth: 32
            implicitHeight: 32

            RoundCorner {
                anchors.fill: parent
                implicitSize: 24
                color: Config.bgPrimary
                corner: RoundCorner.CornerEnum.BottomRight
            }
        }
    }
}
