pragma Singleton
pragma ComponentBehavior: Bound

import QtQml.Models
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    property MprisPlayer trackedPlayer: null
    property MprisPlayer activePlayer: trackedPlayer ?? Mpris.players.values[0] ?? null

    property var activeTrack

    Instantiator {
        model: Mpris.players

        Connections {
            required property MprisPlayer modelData
            target: modelData

            Component.onCompleted: {
                if (root.trackedPlayer == null || modelData.isPlaying) {
                    root.trackedPlayer = modelData;
                }
            }

            function onPlaybackStateChanged() {
                if (root.trackedPlayer !== modelData)
                    root.trackedPlayer = modelData;
            }
        }
    }

    Connections {
        target: activePlayer

        function onPostTrackChanged() {
            root.updateTrack();
        }

        function onMetadataChanged() {
            root.updateTrack();
        }

        function onPlaybackStateChanged() {
            root.updateTrack();
        }
    }

    onActivePlayerChanged: updateTrack()

    function updateTrack() {
        root.activeTrack = {
            title: root.activePlayer?.metadata?.["xesam:title"] ?? "",
            artist: (root.activePlayer?.metadata?.["xesam:artist"] ?? [""])[0]
        };
    }

    function applyRules(track) {
        let result = track;

        for (let rule of Config.mprisRules) {
            let regex = new RegExp(rule.pattern, "i");

            if (regex.test(result)) {
                return rule.replace;
            }
        }

        return result.trim();
    }

    property string track: {
        if (!activeTrack)
            return "";

        let t = "";
        if (activeTrack.artist && activeTrack.title)
            t = activeTrack.title + " - " + activeTrack.artist;
        else
            t = activeTrack.title;

        return applyRules(t);
    }

    property bool isPlaying: activePlayer && activePlayer.isPlaying
}
