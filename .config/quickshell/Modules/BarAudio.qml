import Quickshell.Services.Pipewire

import "./Common/"

StyledText {
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    PwObjectTracker {
        objects: [sink, source]
    }

    text: {
        const microphoneIcon = source?.audio ? source.audio.muted ? "󰍭" : "󰍬" : "~"

        var volume = "~~"
        var volumeIcon = "~"

        if (sink?.audio) {
            volume = Math.round(sink.audio.volume * 100)

            if (volume < 10) volume = "~" + volume

            if (sink.audio.muted) volumeIcon = "󰖁"
            else if (volume < 33) volumeIcon = ""
            else if (volume < 66) volumeIcon = ""
            else volumeIcon = ""
        }

        return microphoneIcon + " " + volumeIcon + " " + volume + "%"
    }
}
