import Quickshell
import QtQuick
import "components"

Scope {
    id: trCorner

    Variants {
        model: Quickshell.screens

        PanelWindow {
            anchors {
                top: true
                right: true
            }

            color: "transparent"

            implicitWidth: 32
            implicitHeight: 32

            RoundCorner {
                anchors.fill: parent
                implicitSize: 24
                color: Config.bgPrimary
                corner: RoundCorner.CornerEnum.TopRight
            }
        }
    }
}
