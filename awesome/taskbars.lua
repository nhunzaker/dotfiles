local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local keys = require("keys")
local helpers = require("helpers")

-- Helper function that creates a button widget
local create_button = function(symbol, color, bg_color, hover_color)
    local widget =
        wibox.widget {
        font = "icomoon 12",
        align = "center",
        id = "text_role",
        valign = "center",
        markup = helpers.colorize_text(symbol, color),
        widget = wibox.widget.textbox()
    }

    local section =
        wibox.widget {
        widget,
        forced_width = dpi(28),
        bg = bg_color,
        widget = wibox.container.background
    }

    -- Hover animation
    section:connect_signal(
        "mouse::enter",
        function()
            section.bg = hover_color
        end
    )
    section:connect_signal(
        "mouse::leave",
        function()
            section.bg = bg_color
        end
    )

    --helpers.add_hover_cursor(section, "hand1")

    return section
end

-- Icon Cheatsheat:
-- https://fontawesome.com/cheatsheet/free/solid
local exit = create_button("", beautiful.xforeground .. "dd", beautiful.xcolor8 .. "30", beautiful.xcolor8 .. "60")
exit:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                exit_screen_show()
            end
        )
    )
)

-- Helper function that updates a tasklist item
local update_tasklist = function(task, c)
    local background = task:get_children_by_id("bg_role")[1]
    local text = task:get_children_by_id("text_role")[1]

    if c.minimized then
        color = "#00000000"
    end

    if client.focus == c then
        text.markup = helpers.colorize_text(text.text, color)
        background.border_color = color
        background.bg = beautiful.xbackground
    else
        text.markup = helpers.colorize_text(text.text, beautiful.xforeground)
        background.bg = beautiful.xbackground
        background.border_color = "#00000000"
    end
end

local tag_colors_empty = {
    "#00000000",
    "#00000000",
    "#00000000",
    "#00000000",
    "#00000000",
    "#00000000",
    "#00000000",
    "#00000000",
    "#00000000",
    "#00000000"
}

local tag_colors_urgent = {
    beautiful.xcolor7,
    beautiful.xcolor7,
    beautiful.xcolor7,
    beautiful.xcolor7,
    beautiful.xcolor7,
    beautiful.xcolor7,
    beautiful.xcolor7,
    beautiful.xcolor7,
    beautiful.xcolor7,
    beautiful.xcolor7
}

local tag_colors_focused = {
    beautiful.xcolor1,
    beautiful.xcolor5,
    beautiful.xcolor4,
    beautiful.xcolor6,
    beautiful.xcolor2,
    beautiful.xcolor3,
    beautiful.xcolor1,
    beautiful.xcolor5,
    beautiful.xcolor4,
    beautiful.xcolor6
}

local tag_colors_occupied = {
    beautiful.xcolor1 .. "55",
    beautiful.xcolor5 .. "55",
    beautiful.xcolor4 .. "55",
    beautiful.xcolor6 .. "55",
    beautiful.xcolor2 .. "55",
    beautiful.xcolor3 .. "55",
    beautiful.xcolor1 .. "55",
    beautiful.xcolor5 .. "55",
    beautiful.xcolor4 .. "55",
    beautiful.xcolor6 .. "55"
}

-- Helper function that updates a taglist item
local update_taglist = function(item, tag, index)
    if tag.selected then
        item.bg = tag_colors_focused[index]
    elseif tag.urgent then
        item.bg = tag_colors_urgent[index]
    elseif #tag:clients() > 0 then
        item.bg = tag_colors_occupied[index]
    else
        item.bg = tag_colors_empty[index]
    end
end

awful.screen.connect_for_each_screen(
    function(s)
        s.mytaglist =
            awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = keys.taglist_buttons,
            layout = wibox.layout.flex.horizontal,
            widget_template = {
                widget = wibox.container.background,
                create_callback = function(self, tag, index, _)
                    update_taglist(self, tag, index)
                end,
                update_callback = function(self, tag, index, _)
                    update_taglist(self, tag, index)
                end
            }
        }
        -- Create a tasklist for every screen
        s.mytasklist =
            awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = keys.tasklist_buttons,
            style = {
                font = beautiful.tasklist_font,
                bg = beautiful.xcolor0
            },
            layout = {
                layout = wibox.layout.flex.horizontal
            },
            widget_template = {
                {
                    {
                        id = "text_role",
                        align = "center",
                        widget = wibox.widget.textbox
                    },
                    forced_width = dpi(180),
                    left = dpi(15),
                    right = dpi(15),
                    -- Add margins to top and bottom in order to force the
                    -- text to be on a single line, if needed. Might need
                    -- to adjust them according to font size.
                    top = dpi(2),
                    bottom = dpi(2),
                    widget = wibox.container.margin
                },
                id = "bg_role",
                widget = wibox.container.background
            }
        }

        -- Create the wibox, this is the bottom bar
        s.mywibox = awful.wibar({screen = s, visible = true, ontop = true, type = "dock", position = "top"})
        s.mywibox.height = beautiful.wibar_height

        -- Bottom bar background color
        s.mywibox.bg = beautiful.xbackground .. "f0"

        -- Bar placement
        awful.placement.maximize_horizontally(s.mywibox)

        -- Create the top bar
        s.mytopwibox =
            awful.wibar({screen = s, visible = true, ontop = false, type = "dock", position = "top", height = dpi(4)})

        -- Bar placement
        awful.placement.maximize_horizontally(s.mytopwibox)
        s.mytopwibox.bg = beautiful.xcolor0 .. "22"

        s.mytopwibox:setup {
            widget = s.mytaglist
        }

        -- Wibar items
        -- Add or remove widgets here
        s.mywibox:setup {
            s.mytasklist,
            wibox.widget {
                widget = wibox.widget.separator,
                thickness = 0
            },
            {
                -- https://www.lua.org/pil/22.1.html
                wibox.widget.textclock(" %I:%M %p    %B %d    "),
                exit,
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal
        }
    end
)

-- We have set the wibar(s) to be ontop, but we do not want it to be above fullscreen clients
local function no_wibar_ontop(c)
    local s = awful.screen.focused()
    if c.fullscreen then
        s.mywibox.ontop = false
    else
        s.mywibox.ontop = true
    end
end

client.connect_signal("focus", no_wibar_ontop)
client.connect_signal("unfocus", no_wibar_ontop)
client.connect_signal("property::fullscreen", no_wibar_ontop)

-- Every bar theme should provide this function:
function toggle_wibars()
    local s = awful.screen.focused()
    s.mywibox.visible = not s.mywibox.visible
    s.mytopwibox.visible = not s.mytopwibox.visible
end
