import QtQuick
import Quickshell.Hyprland
import ".."

Item {
    id: root

    readonly property var win: Hyprland.activeToplevel
    
    function formatClass(cls) {
        if (!cls) return ""
    
        let name = cls.split(".").pop()
        name = name.replace(/[-_]/g, " ")
    
        return name.replace(/\b\w/g, c => c.toUpperCase())
    }
    
    readonly property string windowText: {
        const w = Hyprland.activeToplevel
    
        if (!w)
            return "Desktop"
    
        const initial = w.initialTitle ?? ""
        const cls = formatClass(w.appId || w.class || "")
        const title = w.title ?? ""
    
        return initial || cls || title || "Desktop"
    }

    implicitHeight: 32
    implicitWidth: textItem.implicitWidth

    Text {
        id: textItem
        anchors.centerIn: parent
    
        text: root.windowText
        color: Config.accent
    
        font.family: "Space Grotesk"
        font.pixelSize: 15
        font.letterSpacing: 0.42
        font.weight: 600
    
        elide: Text.ElideRight
        maximumLineCount: 1
        wrapMode: Text.NoWrap
        horizontalAlignment: Text.AlignHCenter
        width: 320
    }
}