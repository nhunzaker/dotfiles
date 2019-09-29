local awful = require("awful")
local window = {}

function window.shift_focus(direction)
    awful.client.focus.bydirection(direction)

    if client.focus then
        client.focus:raise()
    end
end

function window.focus_left()
    window.shift_focus("left")
end

function window.focus_down()
    window.shift_focus("down")
end

function window.focus_right()
    window.shift_focus("right")
end

function window.focus_up()
    window.shift_focus("up")
end

function window.next()
    awful.client.focus.byidx(1)
end

function window.previous()
    awful.client.focus.byidx(-1)
end

function window.more_gutter()
    awful.tag.incgap(5, nil)
end

function window.less_gutter()
    awful.tag.incgap(-5, nil)
end

return window
