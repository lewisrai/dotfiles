import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Text {
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    PwObjectTracker {
        objects: [sink, source]
    }

    readonly property var volume: sink?.audio ? Math.round(sink.audio.volume * 100) : "~"

    readonly property string volumeIcon: {
        if (volume === "~") return "~"
        if (volume === 0 || sink.audio.muted) return "󰖁"
        if (volume < 33) return ""
        if (volume < 66) return ""
        return ""
    }

    readonly property string microphoneIcon: source?.audio ? source.audio.muted ? "󰍭" : "󰍬" : "~"

    text: `${microphoneIcon} ${volumeIcon} ${volume}%`
}
