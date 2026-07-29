import Quickshell.Services.Pipewire

import "./Common/"

StyledText {
    id: audio

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    text: {
        const microphoneIcon = this.source?.audio ? this.source.audio.muted ? "󰍭" : "󰍬" : "~";

        var volumeText = " ~ ~~%";

        if (this.sink?.audio) {
            const volume = Math.round(this.sink.audio.volume * 100);
            const volumeMute = this.sink.audio.muted;

            if (volume < 10)
                volumeText = (volumeMute ? " 󰖁 ~" : " 󰕿 ~") + volume + "%";
            else if (volume < 33)
                volumeText = (volumeMute ? " 󰖁 " : " 󰕿 ") + volume + "%";
            else if (volume < 66)
                volumeText = (volumeMute ? " 󰖁 " : " 󰖀 ") + volume + "%";
            else if (volume < 100)
                volumeText = (volumeMute ? " 󰖁 " : " 󰕾 ") + volume + "%";
            else
                volumeText = (volumeMute ? " 󰖁 " : " 󰕾 ") + "~C%";
        }

        return microphoneIcon + volumeText;
    }

    PwObjectTracker {
        objects: [audio.sink, audio.source]
    }
}
