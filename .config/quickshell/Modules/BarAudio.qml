import Quickshell.Services.Pipewire

import "./Common/"

StyledText {
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    text: {
        const microphoneIcon = this.source?.audio ? this.source.audio.muted ? "󰍭" : "󰍬" : "~";

        var volume = "~~";
        var volumeIcon = "~";

        if (this.sink?.audio) {
            volume = Math.round(this.sink.audio.volume * 100);

            if (volume < 10)
                volume = "~" + volume;

            if (this.sink.audio.muted)
                volumeIcon = "󰖁";
            else if (volume < 33)
                volumeIcon = "";
            else if (volume < 66)
                volumeIcon = "";
            else
                volumeIcon = "";
        }

        return microphoneIcon + " " + volumeIcon + " " + volume + "%";
    }

    PwObjectTracker {
        objects: [this.sink, this.source]
    }
}
