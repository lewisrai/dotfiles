#!/bin/bash

systemctl stop nvidia-persistenced.service

for bdf in 0000:01:00.0 0000:01:00.1; do
    echo "$bdf" > "/sys/bus/pci/devices/$bdf/driver/unbind"
    echo 1 > "/sys/bus/pci/devices/$bdf/remove"
done

echo 1 > /sys/devices/platform/asus-nb-wmi/dgpu_disable
