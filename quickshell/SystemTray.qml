import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: 40
    implicitHeight: trayItems.implicitHeight + 16 + 16

    required property var parentWindow

    function getTrayIcon(name) {
        if (!name)
            return null;

        let str = name.toLowerCase();

        for (let rule of Config.trayIconOverrides) {
            let regex = new RegExp(rule.pattern, "i");
            if (regex.test(str)) {
                return rule;
            }
        }

        return null;
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: Config.bgSecondary
        radius: height / 2
    }

    Column {
        id: trayItems
        spacing: 10
        anchors.centerIn: parent

        Repeater {
            model: SystemTray.items.values

            Item {
                required property int index
                required property var modelData

                width: 24
                height: 24

                ToolTip.visible: mouseArea.containsMouse
                ToolTip.text: modelData.tooltipTitle

                Rectangle {
                    anchors.fill: parent
                    radius: 6
                    color: Config.accent
                    opacity: hovered ? 0.2 : 0.0

                    property bool hovered: false

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: parent.hovered = true
                        onExited: parent.hovered = false
                        cursorShape: Qt.PointingHandCursor

                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                        onClicked: event => {
                            if (event.button === Qt.LeftButton) {
                                modelData.activate();
                            } else if (event.button === Qt.MiddleButton) {
                                if (modelData.secondaryActivate)
                                    modelData.secondaryActivate();
                            } else if (event.button === Qt.RightButton) {
                                let pos = mouseArea.mapToGlobal(0, mouseArea.height);
                                modelData.display(root.parentWindow, pos.x, pos.y);
                            }
                        }
                    }
                }

                Item {
                    anchors.centerIn: parent
                    width: 18
                    height: 18

                    property var override: root.getTrayIcon(modelData.tooltipTitle + modelData.name + modelData.id ?? "")

                    Text {
                        anchors.centerIn: parent
                        visible: parent.override !== null

                        text: parent.override.icon
                        font.family: "Symbols Nerd Font Mono"
                        font.pixelSize: 18
                        color: parent.override ? (parent.override.color ?? Config.accent) : Config.accent
                    }

                    Image {
                        anchors.centerIn: parent
                        visible: parent.override === null

                        source: modelData.icon
                        width: 18
                        height: 18
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
            }
        }
    }
}
