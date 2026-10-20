require("monitors")
require("programs")
require("autostart")
require("environment")
require("permissions")
require("theme")
require("input")
require("keybinds")
require("windows")
require("nvidia")

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-- >>> Brain Shell Startup >>>
dofile(os.getenv("HOME") .. "/.config/Brain_Shell/hypr/brain-shell.lua")
-- <<< Brain Shell Startup <<<
