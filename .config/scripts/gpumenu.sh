integrated=' Integrated'
nvidia=' Nvidia'

case $(echo -e "$integrated\n$nvidia" | rofi -dmenu -theme ~/.config/rofi/menu.rasi) in
    $integrated) pkexec sed -i -e 's/AsusMuxDgpu/Integrated/' /etc/supergfxd.conf && systemctl restart supergfxd && echo -e 'supergfxctl -m Integrated' >> reboot.sh && chmod +x reboot.sh;;
    $nvidia) pkexec sed -i -e 's/Integrated/AsusMuxDgpu/' /etc/supergfxd.conf && systemctl restart supergfxd && echo -e 'supergfxctl -m AsusMuxDgpu' >> reboot.sh && chmod +x reboot.sh;;
esac
