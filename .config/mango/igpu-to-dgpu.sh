if [ "$(id -u)" -ne 0 ]; then
    exit 1
fi

sudo systemctl disable persist-dgpu-disable.service

sudo rm -f /etc/modprobe.d/persist-dgpu-disable.conf

sudo mv /usr/share/vulkan/icd.d/nvidia_icd.json.bak /usr/share/vulkan/icd.d/nvidia_icd.json

asusctl armoury set gpu_mux_mode 0
asusctl armoury set dgpu_disable 0
