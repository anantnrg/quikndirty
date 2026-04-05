pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: sysStats

    property int cpu: 0
    property int ram: 0
    property int temp: 0
    property int net: 0
    property int vol: 0
    property int muted: 0

    Process {
        id: statsProc
        command: ["bash", "-c", "~/.config/quickshell/sysstats.sh"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    let data = JSON.parse(this.text);

                    sysStats.cpu = data.cpu;
                    sysStats.ram = data.ram;
                    sysStats.temp = data.temp;
                    sysStats.net = data.net;
                    sysStats.vol = data.vol;
                    sysStats.muted = data.muted;
                } catch (e) {
                    console.log("JSON parse failed:", this.text);
                }
            }
        }
    }

    Timer {
        interval: 1024
        running: true
        repeat: true
        onTriggered: statsProc.running = true
    }
}
