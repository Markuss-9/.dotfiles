-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all
--
-- Relaunch Hyprland (Super+Escape, then Relaunch) after changing the scale
-- environment variable below.

hl.env("GDK_SCALE", "1")

-- Fallback for any monitor without a rule of its own.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "auto", scale = 1 })

-- Good compromise for 27" or 32" 4K monitors (but fractional!).
-- hl.env("GDK_SCALE", "1.75")
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1.666667 })

-- Optimized for retina-class 2x displays, like 13" 2.8K, 27" 5K, 32" 6K.
-- hl.env("GDK_SCALE", "2")
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 2 })

-- Example for Framework 13 w/ 6K XDR Apple display.
-- hl.monitor({ output = "DP-5", mode = "6016x3384@60", position = "auto", scale = 2 })
-- hl.monitor({ output = "eDP-1", mode = "2880x1920@120", position = "auto", scale = 2 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "*", monitor = "DP-1" })
