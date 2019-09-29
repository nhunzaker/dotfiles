local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local window = require("window")
local hotkeys_popup = require("awful.hotkeys_popup").widget

require("awful.hotkeys_popup.keys")

local keys = {}

-- Mod keys
superkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"
shiftkey = "Shift"

-- {{{ Key bindings
keys.globalkeys =
    gears.table.join(
    -- Focus client by direction (arrow keys)
    awful.key({superkey}, "Down", window.focus_down, {description = "Focus down", group = "Movement"}),
    awful.key({superkey}, "Up", window.focus_up, {description = "Focus up", group = "Movement"}),
    awful.key({superkey}, "Left", window.focus_left, {description = "Focus left", group = "Movement"}),
    awful.key({superkey}, "Right", window.focus_right, {description = "Focus right", group = "Movement"}),
    -- Tab through windows
    awful.key({superkey}, "Tab", window.next, {description = "focus next", group = "Windows"}),
    awful.key({superkey, shiftkey}, "Tab", window.previous, {description = "focus previous", group = "Windows"}),
    -- Gap control
    awful.key({superkey, shiftkey}, "minus", window.less_gutter, {description = "increase gaps size", group = "gaps"}),
    awful.key({superkey}, "minus", window.more_gutter, {description = "decrease gap size", group = "gaps"}),
    -- TODO - Figure out if I want these
    --awful.key({ superkey, ctrlkey }, "j", function () awful.screen.focus_relative( 1) end,
    --{description = "focus the next screen", group = "screen"}),
    --awful.key({ superkey, ctrlkey }, "k", function () awful.screen.focus_relative(-1) end,
    --{description = "focus the previous screen", group = "screen"}),

    -- Spawn terminal
    awful.key(
        {superkey},
        "Return",
        function()
            awful.spawn(user.terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    -- Spawn floating terminal
    awful.key(
        {superkey, shiftkey},
        "Return",
        function()
            awful.spawn(user.floating_terminal, {floating = true})
        end,
        {description = "spawn floating terminal", group = "launcher"}
    ),
    -- Reload Awesome
    awful.key({superkey, shiftkey}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
    -- Quit Awesome
    -- Logout, Shutdown, Restart, Suspend, Lock
    awful.key(
        {superkey},
        "Escape",
        function()
            exit_screen_show()
        end,
        {description = "quit awesome", group = "awesome"}
    ),
    awful.key(
        {superkey, shiftkey},
        "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "Windows"}
    ),
    -- Application launcher
    awful.key(
        {ctrlkey, shiftkey},
        "space",
        function()
            awful.spawn.with_shell("rofi -matching fuzzy -show drun")
        end,
        {description = "rofi launcher", group = "launcher"}
    ),
    -- Screenshots
    awful.key(
        {superkey, shiftkey},
        "c",
        function()
            helpers.screenshot("selection")
        end,
        {description = "select area to capture", group = "screenshots"}
    ),
    awful.key(
        {superkey, ctrlkey},
        "c",
        function()
            helpers.screenshot("clipboard")
        end,
        {description = "select area to copy to clipboard", group = "screenshots"}
    ),
    -- Max layout
    -- Single tap: Set max layout
    -- Double tap: Also disable floating for ALL visible clients in the tag
    awful.key(
        {superkey},
        "w",
        function()
            awful.layout.set(awful.layout.suit.max)
            helpers.single_double_tap(
                nil,
                function()
                    local clients = awful.screen.focused().clients
                    for _, c in pairs(clients) do
                        c.floating = false
                    end
                end
            )
        end,
        {description = "set max layout", group = "tag"}
    ),
    -- Tiling
    -- Single tap: Set tiled layout
    -- Double tap: Also disable floating for ALL visible clients in the tag
    awful.key(
        {superkey},
        "s",
        function()
            awful.layout.set(awful.layout.suit.tile)
            helpers.single_double_tap(
                nil,
                function()
                    local clients = awful.screen.focused().clients
                    for _, c in pairs(clients) do
                        c.floating = false
                    end
                end
            )
        end,
        {description = "set tiled layout", group = "tag"}
    ),
    -- Set floating layout
    awful.key(
        {superkey, shiftkey},
        "s",
        function()
            awful.layout.set(awful.layout.suit.spiral)
        end,
        {description = "set floating layout", group = "tag"}
    ),
    -- App drawer
    awful.key(
        {superkey},
        "a",
        function()
            app_drawer_show()
        end,
        {description = "App drawer", group = "custom"}
    ),
    -- Toggle bars
    awful.key(
        {superkey, shiftkey},
        "b",
        function()
            toggle_wibars()
        end,
        {description = "show or hide wibar(s)", group = "awesome"}
    ),
    -- Spawn file manager
    awful.key(
        {superkey, shiftkey},
        "f",
        function()
            awful.spawn(user.file_manager, {floating = true})
        end,
        {description = "file manager", group = "launcher"}
    )
)

keys.clientkeys =
    gears.table.join(
    -- Move to edge or swap by direction
    awful.key(
        {superkey, shiftkey},
        "Down",
        function(c)
            if c.floating then
                c:relative_move(0, dpi(20), 0, 0)
            else
                helpers.move_client_dwim(c, "down")
            end
        end
    ),
    awful.key(
        {superkey, shiftkey},
        "Up",
        function(c)
            if c.floating then
                c:relative_move(0, dpi(-20), 0, 0)
            else
                helpers.move_client_dwim(c, "up")
            end
        end
    ),
    awful.key(
        {superkey, shiftkey},
        "Left",
        function(c)
            if c.floating then
                c:relative_move(dpi(-20), 0, 0, 0)
            else
                helpers.move_client_dwim(c, "left")
            end
        end
    ),
    awful.key(
        {superkey, shiftkey},
        "Right",
        function(c)
            if c.floating then
                c:relative_move(dpi(20), 0, 0, 0)
            else
                helpers.move_client_dwim(c, "right")
            end
        end
    ),
    awful.key({superkey}, "h", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
    -- Single tap: Center client
    -- Double tap: Center client + Floating + Resize
    awful.key(
        {superkey},
        "c",
        function(c)
            awful.placement.centered(c, {honor_workarea = true, honor_padding = true})
            helpers.single_double_tap(
                nil,
                function()
                    helpers.float_and_resize(c, screen_width * 0.35, screen_height * 0.6)
                end
            )
        end
    ),
    awful.key(
        {superkey, shiftkey, ctrlkey},
        "Down",
        function(c)
            c:relative_move(0, dpi(20), 0, 0)
        end
    ),
    awful.key(
        {superkey, shiftkey, ctrlkey},
        "Up",
        function(c)
            c:relative_move(0, dpi(-20), 0, 0)
        end
    ),
    awful.key(
        {superkey, shiftkey, ctrlkey},
        "Left",
        function(c)
            c:relative_move(dpi(-20), 0, 0, 0)
        end
    ),
    awful.key(
        {superkey, shiftkey, ctrlkey},
        "Right",
        function(c)
            c:relative_move(dpi(20), 0, 0, 0)
        end
    ),
    -- Toggle titlebars (for focused client only)
    awful.key(
        {superkey},
        "t",
        function(c)
            -- Don't toggle if titlebars are used as borders
            if not beautiful.titlebars_imitate_borders then
                decorations.toggle(c)
            -- awful.titlebar.toggle(c)
            end
        end,
        {description = "toggle titlebar", group = "Windows"}
    ),
    -- Toggle fullscreen
    awful.key(
        {superkey},
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "Windows"}
    ),
    -- F for focused view
    awful.key(
        {superkey, ctrlkey},
        "f",
        function(c)
            helpers.float_and_resize(c, screen_width * 0.7, screen_height * 0.75)
        end,
        {description = "focus mode", group = "Windows"}
    ),
    -- V for vertical view
    awful.key(
        {superkey, ctrlkey},
        "v",
        function(c)
            helpers.float_and_resize(c, screen_width * 0.45, screen_height * 0.90)
        end,
        {description = "focus mode", group = "Windows"}
    ),
    -- T for tiny window
    awful.key(
        {superkey, ctrlkey},
        "t",
        function(c)
            helpers.float_and_resize(c, screen_width * 0.3, screen_height * 0.35)
        end,
        {description = "tiny mode", group = "Windows"}
    ),
    -- N for normal size (good for terminals)
    awful.key(
        {superkey, ctrlkey},
        "n",
        function(c)
            helpers.float_and_resize(c, screen_width * 0.45, screen_height * 0.5)
        end,
        {description = "normal mode", group = "Windows"}
    ),
    -- Close client
    awful.key(
        {superkey, shiftkey},
        "q",
        function(c)
            c:kill()
        end,
        {description = "close", group = "Windows"}
    ),
    -- Toggle floating client
    awful.key(
        {superkey, shiftkey},
        "space",
        function(c)
            local layout_is_floating = (awful.layout.get(mouse.screen) == awful.layout.suit.floating)
            if not layout_is_floating then
                awful.client.floating.toggle()
            end
            c:raise()
        end,
        {description = "toggle floating", group = "Windows"}
    ),
    -- Change client opacity
    awful.key(
        {superkey, shiftkey},
        "l",
        function(c)
            awful.layout.inc(1)
        end,
        {description = "change layout forward", group = "Windows"}
    ),
    -- Change client opacity
    awful.key(
        {superkey},
        "l",
        function(c)
            awful.layout.inc(-1)
        end,
        {description = "change layout backward", group = "Windows"}
    ),
    awful.key(
        {superkey, shiftkey},
        "o",
        function(c)
            c.opacity = c.opacity + 0.1
        end,
        {description = "increase client opacity", group = "Windows"}
    ),
    -- P for pin: keep on top OR sticky
    -- On top
    awful.key(
        {superkey, shiftkey},
        "p",
        function(c)
            c.ontop = not c.ontop
        end,
        {description = "toggle keep on top", group = "Windows"}
    ),
    -- Sticky
    awful.key(
        {superkey, ctrlkey},
        "p",
        function(c)
            c.sticky = not c.sticky
        end,
        {description = "toggle sticky", group = "Windows"}
    ),
    -- Minimize
    awful.key(
        {superkey},
        "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "Windows"}
    ),
    -- Maximize
    awful.key(
        {superkey},
        "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "Windows"}
    ),
    awful.key(
        {superkey, ctrlkey},
        "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = "(un)maximize vertically", group = "Windows"}
    ),
    awful.key(
        {superkey, shiftkey},
        "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = "(un)maximize horizontally", group = "Windows"}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local ntags = 10
for i = 1, ntags do
    keys.globalkeys =
        gears.table.join(
        keys.globalkeys,
        -- View tag only.
        awful.key(
            {superkey},
            "#" .. i + 9,
            function()
                -- Tag back and forth
                helpers.tag_back_and_forth(i)

                -- Simple tag view
                -- local tag = mouse.screen.tags[i]
                -- if tag then
                -- tag:view_only()
                -- end
            end,
            {description = "view tag #" .. i, group = "tag"}
        ),
        -- Toggle tag display.
        awful.key(
            {superkey, ctrlkey},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key(
            {superkey, shiftkey},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #" .. i, group = "tag"}
        )
    )
end

-- Mouse buttons on the client (whole window, not just titlebar)
keys.clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            client.focus = c
            c:raise()
        end
    ),
    awful.button({superkey}, 1, awful.mouse.client.move),
    awful.button(
        {superkey},
        2,
        function(c)
            c:kill()
        end
    ),
    awful.button(
        {superkey},
        3,
        function(c)
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
            -- awful.mouse.resize(c, nil, {jump_to_corner=true})
        end
    ),
    -- Superkey + scrolling = Change client opacity
    awful.button(
        {superkey},
        4,
        function(c)
            c.opacity = c.opacity + 0.1
        end
    ),
    awful.button(
        {superkey},
        5,
        function(c)
            c.opacity = c.opacity - 0.1
        end
    )
)

-- Mouse buttons on a tag of the taglist widget
keys.taglist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(t)
            t:view_only()
        end
    ),
    awful.button(
        {modkey},
        1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),
    -- awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button(
        {},
        3,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),
    awful.button(
        {modkey},
        3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),
    awful.button(
        {},
        4,
        function(t)
            awful.tag.viewprev(t.screen)
        end
    ),
    awful.button(
        {},
        5,
        function(t)
            awful.tag.viewnext(t.screen)
        end
    )
)

-- }}}

-- TASK BAR
-- This is the thing at the bottom of the screen that shows all of the
-- programs you have open
-- Mouse buttons on the tasklist

keys.tasklist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
            end
        end
    ),
    -- Middle mouse button closes the window
    awful.button(
        {},
        2,
        function(c)
            c:kill()
        end
    ),
    awful.button(
        {},
        3,
        function(c)
            c.minimized = true
        end
    ),
    awful.button(
        {},
        4,
        function()
            awful.client.focus.byidx(-1)
        end
    ),
    awful.button(
        {},
        5,
        function()
            awful.client.focus.byidx(1)
        end
    ),
    -- Side button up - toggle floating
    awful.button(
        {},
        9,
        function(c)
            -- c:raise()
            c.floating = not c.floating
        end
    ),
    -- Side button down - toggle ontop
    awful.button(
        {},
        8,
        function()
            -- c:raise()
            c.ontop = not c.ontop
        end
    )
)

-- Set keys
root.keys(keys.globalkeys)

return keys
