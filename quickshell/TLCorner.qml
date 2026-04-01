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

            margins {
                right: 60
            }

            color: "transparent"

            implicitWidth: 30
            implicitHeight: 30

            RoundCorner {
                anchors.fill: parent
                implicitSize: 20
                color: "#fff"
                corner: RoundCorner.CornerEnum.TopRight
            }
        }
    }
}
