//@ pragma DefaultEnv QS_DISABLE_CRASH_HANDLER=1
//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
//@ pragma DropExpensiveFonts
//@ pragma UseQApplication

import Quickshell
import Quickshell.Wayland

import "./Modules/"

ShellRoot {
    Bar {}

    Launcher {
        id: launcher
    }

    Notifications {}

    Polkit {}

    Server {}

    Wallpaper {}

    // This stores all the information shared between the lock surfaces on each screen.
    LockContext {
		id: lockContext

		onUnlocked: {
            // Unlock the screen before exiting, or the compositor will display a
			// fallback lock you can't interact with.
			lock.locked = false;
		}
	}

	WlSessionLock {
		id: lock

        // Lock the session immediately when quickshell starts.
		locked: false

		WlSessionLockSurface {
			LockSurface {
				anchors.fill: parent
				context: lockContext
			}
		}
	}
}
