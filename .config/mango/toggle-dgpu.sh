notify-send -h string:tag:gpu "Mux: getting GPU state..."

if lspci | grep 01:00.0; then
    notify-send -h string:tag:gpu "Mux: setting iGPU..."
    supergfxctl -m Integrated
    notify-send -h string:tag:gpu "Mux: iGPU"
else
    notify-send -h string:tag:gpu "Mux: setting dGPU..."
    supergfxctl -m Hybrid
    while [ -z $(lspci | grep 01:00.0) ]; do
        sleep 1
    done
    supergfxctl -m AsusMuxDgpu
    notify-send -h string:tag:gpu "Mux: dGPU"
fi
