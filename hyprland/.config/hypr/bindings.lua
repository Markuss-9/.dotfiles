-- Omarchy's default bindings load first (see hyprland.lua), so everything here
-- overrides them. Rebinding a key that Omarchy already uses needs an
-- hl.unbind() call first, otherwise both dispatchers stay live.
--
-- Inspect the live bindings with: omarchy menu keybindings --print
--
-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

local terminal = os.getenv("TERMINAL") or "xdg-terminal-exec"

-- Launch the terminal in the active window's working directory.
local function terminal_in_cwd(...)
  return o.launch(terminal .. ' --dir="$(omarchy-cmd-terminal-cwd)" ' .. table.concat({ ... }, " "))
end

-- Applications.
o.bind("SUPER + B", "Browser", "omarchy-launch-browser")
o.bind("SUPER + ALT + B", "Browser (private)", "omarchy-launch-browser --private")
o.bind("SUPER + M", "Music", "omarchy-launch-spotify")
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })
o.bind("SUPER + D", "Apps menu", "omarchy-menu toggle apps")

-- Extra keys on the keyboard, bound with no modifiers. F13 and F14 rarely map
-- to a keysym, so they are matched by hardware code.
o.bind("code:191", "Omarchy menu", "omarchy-menu") -- F13
o.bind("code:192", "Terminal", "omarchy-launch-terminal") -- F14

-- Tmux in a terminal opened in the active window's directory. Omarchy's
-- default attaches to the "Work" session when one exists instead of always
-- starting a new one; use { omarchy = "terminal-tmux" } for that behavior.
hl.unbind("SUPER + ALT + RETURN")
o.bind("SUPER + ALT + RETURN", "Tmux", terminal_in_cwd("tmux new"))

-- Send the active workspace to the other monitor.
hl.unbind("SUPER + SHIFT + M")
o.bind("SUPER + SHIFT + M", "Move workspace", function()
  local workspace = hl.get_active_workspace()
  local current = workspace and workspace.monitor and workspace.monitor.name
  local target = current == "DP-1" and "HDMI-A-1" or "DP-1"

  hl.dispatch(hl.dsp.workspace.move({ monitor = target }))
  hl.exec_cmd(o.notify("Moved to " .. target))
end)
