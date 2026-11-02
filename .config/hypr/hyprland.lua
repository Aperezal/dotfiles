------------------------------------------------------------------------------------
--                              HYPRLAND CONFIGURATION (Lua)                      --
-- ------------------------------------------------------------------------------ --
-- Converted from hyprland.conf (hyprlang) for Hyprland 0.55+.                    --
-- Manages the behavior, appearance, and input handling of the compositor.        --
------------------------------------------------------------------------------------

-- -----------------------------------------------------
-- 1. MONITORS
-- -----------------------------------------------------
-- 'eDP-1' is the primary laptop screen with 1.25x scaling for readability.
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1.25 })
hl.monitor({ output = "",      mode = "preferred", position = "auto", scale = 1 })

-- -----------------------------------------------------
-- 2. MY PROGRAMS
-- -----------------------------------------------------
-- $variables become plain Lua locals.
local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "wofi --show drun"
local browser     = "firefox"

-- -----------------------------------------------------
-- 3. AUTOSTART  (exec-once -> hyprland.start event)
-- -----------------------------------------------------
hl.on("hyprland.start", function()
    -- System and Background
    hl.exec_cmd("~/.config/hypr/set_wallpaper.sh")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("kanshi")

    -- Clipboard Manager (Text and Image), history via $mainMod + V
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Scratchpad "Quake Style" (terminal starts hidden for instant open).
    -- Float/size/center/workspace are handled by the window rule in section 7.
    hl.exec_cmd("kitty --class scratchpad_term")
end)

-- -----------------------------------------------------
-- 4. ENVIRONMENT VARIABLES
-- -----------------------------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- -----------------------------------------------------
-- 5. INPUT & DEVICES
-- -----------------------------------------------------
hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "",
        kb_options   = "",
        follow_mouse = 1,
        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },

    cursor = {
        no_hardware_cursors = true,
    },
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- -----------------------------------------------------
-- 6. LOOK AND FEEL
-- -----------------------------------------------------
hl.config({
    general = {
        gaps_in     = 2,
        gaps_out    = 5,
        border_size = 2,

        -- Border colors (Electric Blue)
        col = {
            active_border   = { colors = { "rgba(7287fdee)", "rgba(1e66f5ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    -- Visual effects: rounded corners, opacity, shadows, and blur.
    decoration = {
        rounding = 5,

        -- Opacity (1.0 is solid).
        -- RECOMMENDATION: Set to 0.90 or 0.95 if you want to see the 'blur' effect.
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    -- Configuration for the 'master' tiling engine.
    master = {
        new_status = "master",
    },

    -- Configuration for the 'dwindle' tiling engine (disabled in the original).
    -- dwindle = {
    --     pseudotile     = true,
    --     preserve_split = true,
    -- },

    -- Miscellaneous settings like splash screens and wallpaper handling.
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        -- disable_autoreload   = true,
    },

    animations = {
        enabled = true,
    },
})

-- Window movement and state change transitions.
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1.0 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 } } })

hl.animation({ leaf = "global",           enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",           enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",          enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",           enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",          enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",           enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",     enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- -----------------------------------------------------
-- 7. WINDOW RULES
-- -----------------------------------------------------
-- Scratchpad terminal: replaces the inline
-- [workspace special:scratch silent;float;size 80% 70%;center] exec rule.
-- NOTE: verify the 'size' expression format on your version (see notes).
hl.window_rule({
    name  = "scratchpad-term",
    match = { class = "scratchpad_term" },
    workspace = "special:scratch silent",
    float     = true,
    size      = "monitor_w*0.8 monitor_h*0.7",
    center    = true,
})

-- Prevents apps from forcing a maximize state that breaks tiling.
-- (disabled in the original)
-- hl.window_rule({
--     name  = "suppress-maximize-events",
--     match = { class = ".*" },
--     suppress_event = "maximize",
-- })

-- XWayland Fix: prevents "ghost" windows from stealing focus.
-- (disabled in the original)
-- hl.window_rule({
--     name     = "fix-xwayland-drags",
--     match    = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
--     no_focus = true,
-- })
-- hl.config({ xwayland = { force_zero_scaling = true } })

-- -----------------------------------------------------
-- 8. KEYBINDINGS
-- -----------------------------------------------------
local mainMod = "SUPER" -- Windows/Command key as the modifier.

-- --- Main Applications ---
hl.bind(mainMod .. " + Return",          hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",               hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Space",           hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + F",       hl.dsp.exec_cmd(browser))
hl.bind("ALT + J",                       hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + N",               hl.dsp.exec_cmd("networkmanager_dmenu"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(
    "kitty --class bluetooth_tui -e bluetuith",
    { float = true, size = { 700, 500 }, center = true }
))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(
    "kitty --class btop_custom -e btop",
    { float = true, size = { 950, 650 }, center = true }
))
hl.bind(mainMod .. " + SHIFT + R",       hl.dsp.exec_cmd("killall waybar && waybar &"))

-- --- Basic Window Management ---
hl.bind(mainMod .. " + W",               hl.dsp.window.close())                         -- Close window
hl.bind(mainMod .. " + SHIFT + Q",       hl.dsp.exit())                                 -- Exit Hyprland
hl.bind(mainMod .. " + S",               hl.dsp.window.float({ action = "toggle" }))    -- Toggle floating
hl.bind(mainMod .. " + P",               hl.dsp.window.pseudo())                        -- Pseudo-tiling
hl.bind(mainMod .. " + SHIFT + P",       hl.dsp.exec_cmd("~/.local/bin/hypr-display-menu.sh")) -- Display selection menu
-- hl.bind(mainMod .. " + M",            hl.dsp.layout("togglesplit"))                  -- Toggle split (Horizontal/Vertical)

-- --- SCRATCHPAD (Hidden Console) ---
-- If terminal exists, show it. If not (closed by mistake), launch it.
hl.bind(mainMod .. " + Z",               hl.dsp.exec_cmd("~/.config/hypr/toggle_scratchpad.sh"))

-- --- CLIPBOARD ---
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(
    'cliphist list | wofi --dmenu --width 700 --height 400 --prompt "Clipboard" | cliphist decode | wl-copy'
))

-- --- SCREENSHOTS ---
hl.bind("Print",         hl.dsp.exec_cmd("/home/apereza/.config/hypr/screenshot.sh"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m output -o /tmp -f temp_shot.png && ksnip /tmp/temp_shot.png"))

-- -----------------------------------------------------
-- 9. WINDOWS STYLE NAVIGATION
-- -----------------------------------------------------

-- A. FOCUS (navigate only by looking) -> WIN + ARROWS
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))

-- B. MOVE WINDOWS (move physically) -> WIN + SHIFT + ARROWS
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- C. MAXIMIZE -> WIN + M  (fullscreen mode 1 = maximized)
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- D. RESIZE -> WIN + ALT + ARROWS  (binde = repeating)
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x =  10, y =   0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.resize({ x = -10, y =   0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.resize({ x =   0, y = -10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.resize({ x =   0, y =  10, relative = true }), { repeating = true })

-- -----------------------------------------------------
-- 10. WORKSPACES
-- -----------------------------------------------------
for i = 1, 10 do
    local key = i % 10 -- workspace 10 is on key 0
    -- Switch workspace (1-0)
    hl.bind(mainMod .. " + " .. key,            hl.dsp.focus({ workspace = i }))
    -- Move window to workspace (Shift + 1-0)
    hl.bind(mainMod .. " + SHIFT + " .. key,    hl.dsp.window.move({ workspace = i }))
end

-- Scroll mouse to change workspace
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/Resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multi-monitor binds -- TODO: verify the exact Lua dispatcher names, see notes.
-- Move the active workspace to the next monitor (was: movecurrentworkspacetomonitor, +1)
-- hl.bind("SUPER + SHIFT + M", hl.dsp.workspace.move({ monitor = "+1" }))
-- Swap workspaces between laptop and external monitor (was: swapactiveworkspaces, eDP-1 HDMI-A-1)
-- hl.bind("SUPER + A", hl.dsp.workspace.swap({ "eDP-1", "HDMI-A-1" }))

-- -----------------------------------------------------
-- 11. MULTIMEDIA KEYS
-- -----------------------------------------------------
-- binde -> repeating
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pamixer -i 5"),            { repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pamixer -d 5"),            { repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pamixer -t"),              { repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"),   { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"),   { repeating = true })

-- bindl -> locked (works even when the screen is locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Fallback: manually lock the screen when the lid switch closes
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("pidof hyprlock || hyprlock"), { locked = true })
