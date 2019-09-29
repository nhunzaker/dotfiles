local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local colors = require("colors")
local helpers = require("helpers")

local titlebars = {}

-- TODO: Need to add toggled appearance for sticky, floating, ontop and
-- maximized buttons

-- Helper function that generates clickable buttons for windows
-- Useful for creating simple shaped buttons
local gen_button, gen_button_size, gen_button_margin
local gen_button_size = dpi(10)
local gen_button_margin = dpi(6)
local gen_button_color_unfocused = "#aaaaaa55"

gen_button = function(c, color, hover_color, cmd)
    local button =
        wibox.widget {
        forced_height = gen_button_size,
        forced_width = gen_button_size,
        bg = color,
        border_color = gen_button_color_unfocused,
        border_width = dpi(0),
        shape = gears.shape.circle,
        widget = wibox.container.background()
    }

    -- Instead of adding spacing between the buttons, we add margins
    -- around them. That way it is more forgiving to click them
    -- (especially if they are very small)
    local button_widget =
        wibox.widget {
        button,
        margins = gen_button_margin,
        widget = wibox.container.margin()
    }

    function release()
        cmd(c)
    end

    button_widget:buttons(gears.table.join(awful.button({}, 1, nil, release)))

    -- Hover "animation"
    button_widget:connect_signal(
        "mouse::enter",
        function()
            button.bg = hover_color
            button.border_color = hover_color
            button.opacity = 1
        end
    )

    button_widget:connect_signal(
        "mouse::leave",
        function()
           button.border_color = color
           button.bg = color

           if c == client.focus then
              button.opacty = 1
           else
              button.opacty = 0.25
           end
        end
    )

    -- Press "animation"
    button_widget:connect_signal(
        "button::release",
        function()
            -- do nothing right now
        end
    )

    -- Focus / unfocus
    c:connect_signal(
        "focus",
        function()
           button.opacity = 1
        end
    )

    c:connect_signal(
        "unfocus",
        function()
            button.opacity = 0.25
        end
    )

    return button_widget
end

-- Functions for the generated buttons
local window_close
window_close = function(c)
    c:kill()
end
local window_maximize = function(c)
    c.maximized = not c.maximized
    c:raise()
end
local window_minimize = function(c)
    c.minimized = true
end
local window_sticky = function(c)
    c.sticky = not c.sticky
end
local window_ontop = function(c)
    c.ontop = not c.ontop
end
local window_floating = function(c)
    c.floating = not c.floating
end

-- For anti aliasing
-- =================
-- Save the original beautiful values because they will have to be modified later
local titlebar_bg = beautiful.xbackground
local titlebar_bg_focus = beautiful.titlebar_bg_focus
local titlebar_bg_normal = beautiful.titlebar_bg_normal

local titlebar_container_shape
local wants_equal_padding
local anti_aliasing_padding = beautiful.border_radius * 2

function get_titlebar_color(c)
    if (c.class == "kitty") then
        return beautiful.xbackground .. "f8"
    else
        return beautiful.xbackground
    end
end

if user.anti_aliasing then
    beautiful.titlebar_bg = "#00000000"
    if beautiful.titlebar_bg_focus and beautiful.titlebar_bg_normal then
        beautiful.titlebar_bg_focus = "#00000000"
        beautiful.titlebar_bg_normal = "#00000000"
    end

    -- Function that returns true or false depending on whether the
    -- anti-aliasing titlebars should be added on all sides of a client or not.
    -- Padding is added under the top titlebar, and also titlebars are added to
    -- the left and right of the client in order to have equal padding on
    -- all sides. However they are not necessary for the anti aliasing itself
    -- and can be enabled or disabled per client in this function.
    -- ------------------
    wants_equal_padding = function(c)
        local class = c.class

        if
            class == "Nemo" or class == "music" or class == "email" or class == "htop" or class == "sensors" or
                class == "battop" or
                class == "mpvtube" or
                class == "scratchpad"
         then
            return true
        else
            return false
        end
    end

    -- Only adds 4 anti_aliased titlebars of the same size around the client
    wants_only_borders = function(c)
        local class = c.class
        if class == "feh" or class == "mpv" then
            return true
        else
            return false
        end
    end

    -- titlebar_container_shape = function(radius, tl, tr, br, bl)
    -- Function that returns a rounded shape according to a titlebar position
    titlebar_container_shape = function(radius, position)
        if position == "bottom" then
            return function(cr, width, height)
                gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, radius)
            end
        elseif position == "left" then
            return function(cr, width, height)
                gears.shape.partially_rounded_rect(cr, width, height, true, false, false, true, radius)
            end
        elseif position == "right" then
            return function(cr, width, height)
                gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, radius)
            end
        else -- position == "top" then
            return function(cr, width, height)
                gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, radius)
            end
        end
    end
else
    titlebar_container_shape = function()
        return gears.shape.rectangle
    end
end

-- Mouse buttons
titlebars.buttons =
    gears.table.join(
    -- Left button - move
    awful.button(
        {},
        1,
        function()
            local c = mouse.object_under_pointer()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end
    ),
    -- Middle button - close
    awful.button(
        {},
        2,
        function()
            window_to_kill = mouse.object_under_pointer()
            window_to_kill:kill()
        end
    ),
    -- Right button - resize
    awful.button(
        {},
        3,
        function()
            local c = mouse.object_under_pointer()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
            -- awful.mouse.resize(c, nil, {jump_to_corner=true})
        end
    ),
    -- Side button up - toggle floating
    awful.button(
        {},
        9,
        function()
            local c = mouse.object_under_pointer()
            client.focus = c
            c:raise()
            --awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
            c.floating = not c.floating
        end
    ),
    -- Side button down - toggle ontop
    awful.button(
        {},
        8,
        function()
            local c = mouse.object_under_pointer()
            client.focus = c
            c:raise()
            c.ontop = not c.ontop
        end
    )
)

-- Disable popup tooltip on titlebar button hover
awful.titlebar.enable_tooltip = false

-- Add a titlebar
client.connect_signal(
    "request::titlebars",
    function(c)
        local buttons = titlebars.buttons

        local title_widget
        if beautiful.titlebar_title_enabled then
            title_widget = awful.titlebar.widget.titlewidget(c)
            title_widget.font = beautiful.titlebar_font
            title_widget:set_align(beautiful.titlebar_title_align)
        else
            title_widget = wibox.widget.textbox("")
        end

        -- Create 4 dummy titlebars around the window to imitate borders
        if beautiful.titlebars_imitate_borders then
            awful.titlebar(c, {position = "top", size = beautiful.titlebar_size})
            awful.titlebar(c, {position = "bottom", size = beautiful.titlebar_size})
            awful.titlebar(c, {position = "right", size = beautiful.titlebar_size})
            awful.titlebar(c, {position = "left", size = beautiful.titlebar_size})
        else
            local anti_aliasing_padding_color = beautiful.xbackground

            -- Save these here in order to avoid re-evaluating them multiple times
            local equal_padding = wants_equal_padding(c)
            local only_borders = wants_only_borders(c)

            -- Top titlebar
            local titlebar_container =
                wibox.widget {
                shape = titlebar_container_shape(beautiful.border_radius, "top"),
                bg = get_titlebar_color(c),
                widget = wibox.container.background
            }

            awful.titlebar(
                c,
                {
                    font = beautiful.titlebar_font,
                    position = beautiful.titlebar_position,
                    size = (user.anti_aliasing and equal_padding) and beautiful.titlebar_size + anti_aliasing_padding or
                        (user.anti_aliasing and only_borders) and anti_aliasing_padding or
                        beautiful.titlebar_size
                }
            ):setup {
                {
                    {
                        nil,
                        {
                            buttons = buttons,
                            widget = title_widget
                        },
                        {
                            -- AwesomeWM native buttons (images loaded from theme)
                            -- awful.titlebar.widget.minimizebutton(c),
                            -- awful.titlebar.widget.floatingbutton(c),
                            -- awful.titlebar.widget.maximizedbutton(c),
                            -- awful.titlebar.widget.closebutton(c),

                            -- Generated buttons
                            gen_button(c, "#ffaa00", "#ffcc22", window_minimize),
                            gen_button(c, "#339900", "#55bb22", window_maximize),
                            gen_button(c, "#aa3300", "#cc5500", window_close),
                            -- Pushes buttons over on the right-hand
                            -- size to create consistent spacing
                            {
                                forced_width = gen_button_margin * 0.5,
                                layout = wibox.layout.fixed.horizontal
                            },
                            layout = wibox.layout.fixed.horizontal
                        },
                        visible = not only_borders,
                        forced_height = beautiful.titlebar_size,
                        layout = wibox.layout.align.horizontal
                    },
                    -- Padding
                    -- Only visible when equal padding is desired for the client
                    {
                        visible = user.anti_aliasing and equal_padding or only_borders,
                        buttons = user.anti_aliasing and only_borders and buttons,
                        -- bg = beautiful.xbackground,
                        bg = anti_aliasing_padding_color,
                        -- bg = only_borders and anti_aliasing_padding_color or beautiful.xbackground,
                        forced_height = anti_aliasing_padding,
                        widget = wibox.container.background
                    },
                    layout = wibox.layout.fixed.vertical
                },
                widget = titlebar_container
            }

            if user.anti_aliasing then
                local bottom_titlebar_container =
                    wibox.widget {
                    shape = titlebar_container_shape(beautiful.border_radius, "bottom"),
                    bg = get_titlebar_color(c),
                    widget = wibox.container.background
                }

                -- Add padding left and right if needed
                if equal_padding or only_borders then
                    awful.titlebar(
                        c,
                        {
                            font = beautiful.titlebar_font,
                            position = "right",
                            size = anti_aliasing_padding,
                            bg = "#00000000"
                        }
                    ):setup {
                        buttons = titlebars.buttons,
                        bg = anti_aliasing_padding_color,
                        widget = wibox.container.background()
                    }
                    awful.titlebar(
                        c,
                        {
                            font = beautiful.titlebar_font,
                            position = "left",
                            size = anti_aliasing_padding,
                            bg = "#00000000"
                        }
                    ):setup {
                        buttons = titlebars.buttons,
                        bg = anti_aliasing_padding_color,
                        widget = wibox.container.background()
                    }
                    -- Change the color of the bottom titlebar
                    bottom_titlebar_container.bg = anti_aliasing_padding_color
                else
                    -- Change the titlebar color depending on focus
                    if beautiful.titlebar_bg_focus and beautiful.titlebar_bg_normal then
                        c:connect_signal(
                            "focus",
                            function()
                                titlebar_container.bg = titlebar_bg_focus
                                bottom_titlebar_container.bg = titlebar_bg_focus
                            end
                        )
                        c:connect_signal(
                            "unfocus",
                            function()
                                titlebar_container.bg = titlebar_bg_normal
                                bottom_titlebar_container.bg = titlebar_bg_normal
                            end
                        )
                    end
                end

                -- Create an anti-aliased bottom titlebar in order to round the bottom corners
                awful.titlebar(c, {font = beautiful.titlebar_font, position = "bottom", size = anti_aliasing_padding}):setup {
                    widget = bottom_titlebar_container
                }
            end
        end
    end
)

-- Wrappers around awful.titlebar.hide and show
decorations = {}
if user.anti_aliasing then
    decorations.show = function(c)
        if wants_equal_padding(c) or wants_only_borders(c) then
            awful.titlebar.show(c, "left")
            awful.titlebar.show(c, "right")
        end
        awful.titlebar.show(c, "top")
        awful.titlebar.show(c, "bottom")
    end
    decorations.hide = function(c)
        if wants_equal_padding(c) or wants_only_borders(c) then
            awful.titlebar.hide(c, "left")
            awful.titlebar.hide(c, "right")
        end
        awful.titlebar.hide(c, "top")
        awful.titlebar.hide(c, "bottom")
    end
    decorations.toggle = function(c)
        if wants_equal_padding(c) or wants_only_borders(c) then
            awful.titlebar.toggle(c, "left")
            awful.titlebar.toggle(c, "right")
        end
        awful.titlebar.toggle(c, "top")
        awful.titlebar.toggle(c, "bottom")
    end
else
    decorations.show = function(c)
        awful.titlebar.show(c, beautiful.titlebar_position)
    end
    decorations.hide = function(c)
        awful.titlebar.hide(c, beautiful.titlebar_position)
    end
    decorations.toggle = function(c)
        awful.titlebar.toggle(c, beautiful.titlebar_position)
    end
end

return titlebars
