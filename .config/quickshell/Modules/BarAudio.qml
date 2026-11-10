import Quickshell.Services.Pipewire

import "./Common/"

StyledText {
    id: audio

    readonly property string microphoneIcon: this.source?.audio ? this.source.audio.muted ? "󰍭" : "󰍬" : "~"
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource
    readonly property string volumeText: {
        if (!this.sink?.audio)
            return " ~ ~~%";

        const volume = Math.round(this.sink.audio.volume * 100);
        const icon = this.sink.audio.muted ? " 󰖁 " : volume < 33 ? " 󰕿 " : volume < 66 ? " 󰖀 " : " 󰕾 ";
        const text = volume < 10 ? "~" + volume + "%" : volume < 100 ? volume + "%" : "~C%";

        return icon + text;
    }

    text: this.microphoneIcon + this.volumeText

    PwObjectTracker {
        objects: [audio.sink, audio.source]
    }
}
