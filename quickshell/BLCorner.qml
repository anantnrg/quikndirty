import Quickshell
import QtQuick
import "components"

Scope {
    id: blCorner

    Variants {
        model: Quickshell.screens

        PanelWindow {
            anchors {
                bottom: true
                left: true
            }

            color: "transparent"

            implicitWidth: 32
            implicitHeight: 32

            RoundCorner {
                anchors.fill: parent
                implicitSize: 24
                color: Config.bgPrimary
                corner: RoundCorner.CornerEnum.BottomLeft
            }
        }
    }
}
