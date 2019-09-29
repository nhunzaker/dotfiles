local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- Get theme variables
local floating_icon = beautiful.layout_floating
local tile_icon = beautiful.layout_tile
local max_icon = beautiful.layout_max
local desktop_control = wibox.widget.textbox()

-- Mouse control
desktop_control:buttons(
    gears.table.join(
        -- Left click - Cycle through layouts
        awful.button(
            {},
            1,
            function()
                awful.layout.inc(1)
            end
        ),
        -- Right click - Cycle backgrounds through layouts
        awful.button(
            {},
            3,
            function()
                awful.layout.inc(-1)
            end
 )
    )
)

local function update_widget()
    local current_layout = awful.layout.get(mouse.screen)
    desktop_control.text = current_layout.name
end

-- Signals
awful.tag.attached_connect_signal(
    s,
    "property::selected",
    function()
        update_widget()
    end
)
awful.tag.attached_connect_signal(
    s,
    "property::layout",
    function()
        update_widget()
    end
)

return desktop_control
