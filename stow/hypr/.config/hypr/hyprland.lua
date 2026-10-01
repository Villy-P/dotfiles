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

-- Brain Shell Autostarts
hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle -c " .. os.getenv("HOME") .. "/.local/src/Brain_Shell/src/config/hypridle.conf")
    hl.exec_cmd("quickshell -c " .. os.getenv("HOME") .. "/.local/src/Brain_Shell")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

-- Brain_ShellKeybinds
dofile("/home/valerius/.config/Brain_Shell/Brain_ShellKeybinds.lua")
