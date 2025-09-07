integrated=' Integrated'
nvidia=' Nvidia'

case $(echo -e "$integrated\n$nvidia" | rofi -dmenu -theme ~/.config/rofi/menu.rasi) in
    $integrated)
        pkexec sh -c 'sed -i -e "s/AsusMuxDgpu/Integrated/" /etc/supergfxd.conf && systemctl restart supergfxd'
        echo -e 'supergfxctl -m Integrated' >> reboot.sh;;
    $nvidia)
        pkexec sh -c 'sed -i -e "s/Integrated/AsusMuxDgpu/" /etc/supergfxd.conf && systemctl restart supergfxd'
        echo -e 'supergfxctl -m AsusMuxDgpu' >> reboot.sh;;
esac

chmod +x reboot.sh
