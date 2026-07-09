hl.monitor({
    output = "desc:BOE 0x0A0B",
    mode = "2560x1600@60",
    position = "0x0",
    scale = "1",
})

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "1",
    mirror = "desc:BOE 0x0A0B",
})

hl.bind("SUPER + q", hl.dsp.window.close())
hl.bind("SUPER + w", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SUPER + r", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("SUPER + f", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind("SUPER + e", hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + return", hl.dsp.exec_cmd("foot"))
hl.bind("SUPER + b", hl.dsp.exec_cmd("helium-browser"))
hl.bind("SUPER + n", hl.dsp.exec_cmd("foot -e nvim"))
hl.bind("SUPER + m", hl.dsp.layout("swapwithmaster master"))

hl.bind("SUPER + space", hl.dsp.exec_cmd("bemenu-run -C -i -l 10 -p $ -T --fixed-height --single-instance -c -W 0.25 -B 2 -R 8"))

hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))

hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))

hl.bind("SUPER + SHIFT + r", hl.dsp.exec_cmd("powerprofilesctl set power-saver; asusctl armoury set panel_overdrive 0; systemctl reboot"))
hl.bind("SUPER + SHIFT + o", hl.dsp.exec_cmd("powerprofilesctl set power-saver; asusctl armoury set panel_overdrive 0; loginctl terminate-session ''"))
hl.bind("SUPER + SHIFT + p", hl.dsp.exec_cmd("powerprofilesctl set power-saver; asusctl armoury set panel_overdrive 0; systemctl poweroff"))

hl.bind("SUPER + SHIFT + s", hl.dsp.exec_cmd("systemd-ac-power || systemctl suspend"))
hl.bind("SUPER + SHIFT + d", hl.dsp.exec_cmd("brightnessctl set 1%"))
hl.bind("SUPER + SHIFT + g", hl.dsp.exec_cmd("~/.config/hypr/toggle-dgpu.sh"))
hl.bind("SUPER + SHIFT + l", hl.dsp.exec_cmd("loginctl lock-session"))

hl.bind("SUPER + SHIFT + x", hl.dsp.exec_cmd("~/.config/hypr/enable-xwayland.sh"))
hl.bind("SUPER + SHIFT + b", hl.dsp.exec_cmd("brightnessctl set 50%"))
hl.bind("SUPER + SHIFT + n", hl.dsp.exec_cmd("~/.config/hypr/toggle-no-blue.sh"))

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("asusctl leds prev"), { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("asusctl leds next"), { locked = true, repeating = true })
hl.bind("XF86Launch1", hl.dsp.exec_cmd("~/.config/hypr/toggle-game-mode.sh"))
hl.bind("XF86Launch3", hl.dsp.exec_cmd("asusctl aura power keyboard --awake; asusctl aura effect static --colour f5c2e7"), { locked = true })
hl.bind("XF86Launch4", hl.dsp.exec_cmd("~/.config/hypr/next-performance-mode.sh"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })

hl.window_rule({
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    match = {
        xwayland = true,
    },
    border_color = "rgb(b4befe)",
})

hl.window_rule({
    match = {
        class = "blueman-manager",
    },
    float = true,
    move = "1918 82",
    size = "600 480",
    pin = true,
})

hl.window_rule({
    match = {
        class = "com.saivert.pwvucontrol",
    },
    float = true,
    move = "1918 82",
    size = "600 480",
    pin = true,
})

hl.window_rule({
    match = {
        class = "proton.vpn.app.gtk",
    },
    float = true,
    move = "42 82",
    size = "474 700",
    pin = true,
})

hl.window_rule({
    match = {
        class = "protonvpn-app",
    },
    float = true,
    move = "42 82",
    size = "474 700",
    pin = true,
})

hl.permission({ binary = "/usr/bin/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/hyprlock", type = "screencopy", mode = "deny" })

hl.config({
    general = {
        border_size = 2,
        gaps_in = 6,
        gaps_out = {
            top = 12,
            right = 20,
            bottom = 20,
            left = 20,
        },
        col = {
            inactive_border = "rgb(595959)",
            active_border = "rgb(f5c2e7)",
        },
        layout = "master",
    },
    decoration = {
        rounding = 6,
        blur = {
            enabled = false,
        },
        shadow = {
            enabled = false,
        },
    },
    animations = {
        enabled = false,
    },
    input = {
        kb_layout = "gb",
        kb_options = "caps:escape",
        accel_profile = "flat",
        touchpad = {
            natural_scroll = true,
        },
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        col = {
            splash = "rgb(313244)",
        },
        force_default_wallpaper = 0,
        disable_autoreload = true,
        enable_anr_dialog = false,
        disable_watchdog_warning = true,
    },
    xwayland = { enabled = false },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
        enforce_permissions = true,
    },
    master = {
        mfact = 0.5,
        new_status = "slave",
    },
})

hl.device({
    name = "asue120d:00-04f3:31fb-touchpad",
    accel_profile = "",
})

function enable_xwayland()
    identifier = 1

    if identifier == 0 then
        return
    end

    hl.config({
        xwayland = { enabled = true },
    })
end

enable_xwayland()

hl.on("hyprland.start", function()
    hl.exec_cmd("wbg .config/hypr/wallpaper.png")
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("/home/laptop/.config/hypr/polkit-agent.sh")
end)
