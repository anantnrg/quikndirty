import Quickshell
import QtQuick
import "components"

Scope {
    id: tlCorner

    Variants {
        model: Quickshell.screens

        PanelWindow {
            anchors {
                top: true
                right: true
            }

            color: "transparent"

            implicitWidth: 30
            implicitHeight: 30

            RoundCorner {
                anchors.fill: parent
                implicitSize: 20
                color: Config.bgPrimary
                corner: RoundCorner.CornerEnum.TopRight
            }
        }
    }
}
