//@ pragma UseQApplication
//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1

import Quickshell

import "./Modules/"

ShellRoot {
    Bar {}

    Notifications {}

    Polkit {}

    Wallpaper {}
}
