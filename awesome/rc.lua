local awful = require("awful")

awful.spawn.with_shell(os.getenv("HOME") .. "/.config/awesome/autostart.sh")

local icon_theme_name = "drops"

-- Initialization
-- ===================================================================

-- Theme handling library
local beautiful = require("beautiful")

beautiful.init(require("theme"))

local xresources = require("beautiful.xresources")

-- Make dpi function global
dpi = xresources.apply_dpi

local gears = require("gears")
local wibox = require("wibox")

require("awful.autofocus")

-- Default notification library
local naughty = require("naughty")

local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")

-- Error handling
-- ====================================================== =============
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        }
    )
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal(
        "debug::error",
        function(err)
            -- Make sure we don't go into an endless error loop
            if in_error then
                return
            end
            in_error = true

            naughty.notify(
                {
                    preset = naughty.config.presets.critical,
                    title = "Oops, an error happened!",
                    text = tostring(err)
                }
            )
            in_error = false
        end
    )
end

-- Variable definitions
-- ===================================================================
-- User variables and preferences
user = {
    -- >> Default applications <<
    terminal = "kitty -1",
    floating_terminal = "kitty -1",
    browser = "brave",
    file_manager = "nautilus",
    editor = "emacs",
    -- >> Music <<
    music_client = "spotify",
    -- >> Screenshots <<
    -- TODO: Make sure the directory exists!
    screenshot_dir = os.getenv("HOME") .. "/Pictures",
    -- >> Email <<
    email_client = "kitty -1 --class email -e neomutt",
    -- >> Anti-aliasing <<
    -- ------------------
    -- Requires a compositor to be running.
    -- ------------------
    -- Currently this works if you set your titlebar position to "top", but it
    -- is trivial to make it work for any titlebar position.
    -- ------------------
    -- This setting only affects clients, but you can "manually" apply
    -- anti-aliasing to other wiboxes. Check out the notification
    -- widget_template in notifications.lua for an example.
    -- ------------------
    -- If anti_aliasing is set to true, the top titlebar corners are
    -- antialiased and a small titlebar is also added at the bottom in order to
    -- round the bottom corners.
    -- If anti_aliasing set to false, the client shape will STILL be rounded,
    -- just without anti-aliasing, according to your theme's border_radius
    -- variable.
    -- ------------------
    anti_aliasing = true,
    -- >> Lock screen <<
    -- You can set this to whatever you want or leave it empty in
    -- order to unlock with just the Enter key.
    lock_screen_password = "awesome"
    -- lock_screen_password = "",
}

-- Features
-- ===================================================================
-- Load icon theme
icons = require("icons")
icons.init(icon_theme_name)

-- Helper functions
-- What would I do without them?
local helpers = require("helpers")

-- Keybinds and mousebinds
local keys = require("keys")

-- Titlebars
require("titlebars")

-- Notification settings
require("notifications")

-- Task bar and desktop management
require("taskbars")

-- Exit screen
local exit_screen = require("noodle.exit_screen_v2")

-- Lock screen
local lock_screen = require("noodle.lock_screen")

-- Daemons
-- Most widgets that display system info depend on evil
--require("evil")

-- ===================================================================
-- ===================================================================

-- Get screen geometry
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- Layouts
-- ===================================================================

-- Table of layouts to cover with awful.layout.inc, order matters.

awful.layout.layouts = {
    -- These loosely match Kitty's layouts
    awful.layout.suit.tile.right,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.spiral
    --    awful.layout.suit.tile.top,
    --    awful.layout.suit.tile.left,
    --    awful.layout.suit.spiral.dwindle,
    --    awful.layout.suit.floating,
    --    awful.layout.suit.max.fullscreen,
    --    awful.layout.suit.magnifier,
    --    awful.layout.suit.corner.nw,
    --    awful.layout.suit.corner.ne,
    --    awful.layout.suit.corner.sw,
    --    awful.layout.suit.corner.se,
}

-- Tags
-- ===================================================================
awful.screen.connect_for_each_screen(
    function(s)
        local name = "Screen " .. tostring(s.index)
        local width = s.geometry.width
        local height = s.geometry.height
        local layout = awful.layout.suit.spiral

        -- Change the layout for vertical monitors
        if height > width then
            layout = awful.layout.suit.fair
        end

        -- Tag layouts
        -- https://awesomewm.org/apidoc/libraries/awful.layout.html#Client_layouts
        local layouts = {
            layout
        }

        -- Tag names
        local tagnames = {
            name .. " 1",
            name .. " 2",
            name .. " 3",
            name .. " 4",
            name .. " 5",
            name .. " 6",
            name .. " 7"
        }

        -- Create all tags at once (without seperate configuration for each tag)
        awful.tag(tagnames, s, layouts)
    end
)

-- Determines how floating clients should be placed
local client_placement_f = awful.placement.no_overlap + awful.placement.no_offscreen

-- Rules
-- ===================================================================

awful.rules.rules = {
    {
        -- All clients will match this rule.
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            -- Open new windows on the current screen they are on. Additionally
            -- this keeps windows in the same position when rebooting awesome
            screen = awful.screen.preferred,
            -- Enable to remember the last window size
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true
        },
        callback = function(c)
            if not awesome.startup then
                -- If the layout is floating or there are no other visible clients
                -- Apply placement function
                if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating or #mouse.screen.clients == 1 then
                    awful.placement.centered(c, {honor_padding = true, honor_workarea = true})
                else
                    client_placement_f(
                        c,
                        {honor_padding = true, honor_workarea = true, margins = beautiful.useless_gap * 2}
                    )
                end

                if not beautiful.titlebars_enabled then
                    decorations.hide(c)
                end
            end
        end
    },
    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {type = {"normal", "dialog"}},
        properties = {titlebars_enabled = true}
    },
    -- Floating clients
    {
        rule_any = {
            instance = {
                "copyq", -- Includes session name in class.
                "floating_terminal"
            },
            class = {
                "mpv",
                "Gpick",
                "Lxappearance",
                "Nm-connection-editor",
                "File-roller",
                "fst"
            },
            name = {
                "Event Tester" -- xev
            },
            role = {
                "AlarmWindow",
                "pop-up",
                "GtkFileChooserDialog",
                "conversation"
            },
            type = {
                "dialog"
            }
        },
        properties = {floating = true, ontop = false}
    },
    {
        rule_any = {
            type = {
                "dialog"
            },
            class = {
                "Io.elementary.calculator"
            },
            role = {
                "GtkFileChooserDialog",
                "conversation"
            }
        },
        properties = {},
        callback = function(c)
            awful.placement.centered(c, {honor_padding = true, honor_workarea = true})
        end
    },
    -- Titlebars OFF (explicitly)
    -- Titlebars of these clients will be hidden regardless of the theme setting
    {
        rule_any = {
            class = {
                "Firefox",
                "Brave",
                "Chromium"
            }
        },
        properties = {},
        callback = function(c)
            if not beautiful.titlebars_imitate_borders then
                decorations.hide(c)
            -- awful.titlebar.hide(c)
            end
        end
    },
    {
        rule_any = {role = {"GtkFileChooserDialog"}},
        properties = {floating = true, width = screen_width * 0.55, height = screen_height * 0.65}
    },
    -- Pavucontrol
    {
        rule_any = {class = {"Pavucontrol"}},
        properties = {floating = true, width = dpi(600), height = dpi(450)}
    },
    -- File managers
    {
        rule_any = {
            class = {
                "Nemo",
                "Thunar",
                "Nautilus"
            }
        },
        except_any = {
            type = {"dialog"}
        },
        properties = {floating = true, width = screen_width * 0.45, height = screen_height * 0.55}
    },
    -- Image viewers
    {
        rule_any = {
            class = {
                "feh",
                "Sxiv",
                "Nitrogen"
            }
        },
        properties = {
            floating = true,
            width = math.min(screen_width * 0.4, dpi(1024)),
            height = math.min(screen_width * 0.4, dpi(576))
        },
        callback = function(c)
            awful.placement.centered(c, {honor_padding = true, honor_workarea = true})
        end
    },
    -- Browsing
    {
        rule_any = {
            class = {}
        },
        except_any = {
            role = {"GtkFileChooserDialog"},
            type = {"dialog"}
        },
        properties = {screen = 1, tag = awful.screen.focused().tags[1]}
    }
}

-- (Rules end here) ..................................................
-- ===================================================================

-- Signals
-- ===================================================================
-- Signal function to execute when a new client appears.
client.connect_signal(
    "manage",
    function(c)
        -- Set every new window as a slave,
        -- i.e. put it at the end of others instead of setting it master.
        if not awesome.startup then
            awful.client.setslave(c)
        end
    end
)

-- Apply rounded corners to clients
-- (If antialiasing is enabled, the rounded corners are applied in
-- titlebars.lua)
if not user.anti_aliasing then
    if beautiful.border_radius ~= 0 then
        client.connect_signal(
            "manage",
            function(c, startup)
                if not c.fullscreen and not c.maximized then
                    c.shape = helpers.rrect(beautiful.border_radius)
                end
            end
        )

        -- Fullscreen and maximized clients should not have rounded corners
        local function no_round_corners(c)
            if c.fullscreen or c.maximized then
                c.shape = gears.shape.rectangle
            else
                c.shape = helpers.rrect(beautiful.border_radius)
            end
        end

        client.connect_signal("property::fullscreen", no_round_corners)
        client.connect_signal("property::maximized", no_round_corners)

        beautiful.snap_shape = helpers.rrect(beautiful.border_radius * 2)
    else
        beautiful.snap_shape = gears.shape.rectangle
    end
end

if beautiful.taglist_item_roundness ~= 0 then
    beautiful.taglist_shape = helpers.rrect(beautiful.taglist_item_roundness)
end

if beautiful.notification_border_radius ~= 0 then
    beautiful.notification_shape = helpers.rrect(beautiful.notification_border_radius)
end

-- When a client starts up in fullscreen, resize it to cover the fullscreen a short moment later
-- Fixes wrong geometry when titlebars are enabled
--client.connect_signal("property::fullscreen", function(c)
client.connect_signal(
    "manage",
    function(c)
        if c.fullscreen then
            gears.timer.delayed_call(
                function()
                    if c.valid then
                        c:geometry(c.screen.geometry)
                    end
                end
            )
        end
    end
)

if beautiful.border_width > 0 then
    client.connect_signal(
        "focus",
        function(c)
            c.border_color = beautiful.border_focus
        end
    )
    client.connect_signal(
        "unfocus",
        function(c)
            c.border_color = beautiful.border_normal
        end
    )
end

-- Set mouse resize mode (live or after)
awful.mouse.resize.set_mode("live")

-- Restore geometry for floating clients
-- (for example after swapping from tiling mode to floating mode)
-- ==============================================================
tag.connect_signal(
    "property::layout",
    function(t)
        for k, c in ipairs(t:clients()) do
            if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
                -- Geometry x = 0 and y = 0 most probably means that the client's
                -- floating_geometry has not been set yet.
                -- If that is the case, don't change their geometry
                -- TODO does this affect clients that are really placed in 0,0  ?
                local cgeo = awful.client.property.get(c, "floating_geometry")
                if cgeo and not (cgeo.x == 0 and cgeo.y == 0) then
                    c:geometry(awful.client.property.get(c, "floating_geometry"))
                end
            end
        end
    end
)

client.connect_signal(
    "manage",
    function(c)
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            awful.client.property.set(c, "floating_geometry", c:geometry())
        end
    end
)

client.connect_signal(
    "property::geometry",
    function(c)
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            awful.client.property.set(c, "floating_geometry", c:geometry())
        end
    end
)

-- Make rofi able to unminimize minimized clients
client.connect_signal(
    "request::activate",
    function(c, context, hints)
        if not awesome.startup then
            if c.minimized then
                c.minimized = false
            end
            awful.ewmh.activate(c, context, hints)
        end
    end
)
