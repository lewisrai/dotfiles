if [ "$(id -u)" -ne 0 ]; then
    exit 1
fi

sudo systemctl enable persist-dgpu-disable.service

cat << 'EOF' | sudo tee -i /etc/modprobe.d/persist-dgpu-disable.conf
blacklist nouveau
blacklist nvidia_drm
blacklist nvidia_uvm
blacklist nvidia_modeset
blacklist nvidia
blacklist nvidia-wmi-ec-backlight
options nvidia-drm modeset=1
options nvidia-wmi-ec-backlight force=1
EOF

sudo mv /usr/share/vulkan/icd.d/nvidia_icd.json /usr/share/vulkan/icd.d/nvidia_icd.json.bak

asusctl armoury set gpu_mux_mode 1
asusctl armoury set dgpu_disable 1
