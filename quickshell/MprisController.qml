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
    }

    onActivePlayerChanged: updateTrack()

    function updateTrack() {
        root.activeTrack = {
            title: root.activePlayer?.metadata?.["xesam:title"] ?? "",
            artist: (root.activePlayer?.metadata?.["xesam:artist"] ?? [""])[0]
        };
    }

    property string track: {
        if (!activeTrack)
            return "";
        if (activeTrack.artist && activeTrack.title)
            return activeTrack.artist + " - " + activeTrack.title;
        return activeTrack.title;
    }

    property bool isPlaying: activePlayer && activePlayer.isPlaying
}
