local wibox = require("wibox")
local gears = require("gears")
local theme_name = "ephemeral"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local xrdb = xresources.get_current_theme()
local theme = {}

-- This is used to make it easier to align the panels in specific monitor positions
local awful = require("awful")
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

theme.font = "IBM Plex Sans 9"

-- Get colors from .Xresources and set fallback colors
theme.xbackground = xrdb.background or "#1D1F28"
theme.xforeground = xrdb.foreground or "#FDFDFD"
theme.xcolor0 = xrdb.color0 or "#282A36"
theme.xcolor1 = xrdb.color1 or "#F37F97"
theme.xcolor2 = xrdb.color2 or "#5ADECD"
theme.xcolor3 = xrdb.color3 or "#F2A272"
theme.xcolor4 = xrdb.color4 or "#8897F4"
theme.xcolor5 = xrdb.color5 or "#C574DD"
theme.xcolor6 = xrdb.color6 or "#79E6F3"
theme.xcolor7 = xrdb.color7 or "#FDFDFD"
theme.xcolor8 = xrdb.color8 or "#414458"
theme.xcolor9 = xrdb.color9 or "#FF4971"
theme.xcolor10 = xrdb.color10 or "#18E3C8"
theme.xcolor11 = xrdb.color11 or "#FF8037"
theme.xcolor12 = xrdb.color12 or "#556FFF"
theme.xcolor13 = xrdb.color13 or "#B043D1"
theme.xcolor14 = xrdb.color14 or "#3FDCEE"
theme.xcolor15 = xrdb.color15 or "#BEBEC1"

-- This is how to get other .Xresources values (beyond colors 0-15, or custom variables)
-- local cool_color = awesome.xrdb_get_value("", "color16")

theme.bg_dark = theme.xbackground
theme.bg_normal = theme.xcolor0
theme.bg_focus = theme.xcolor8
theme.bg_urgent = theme.xcolor8
theme.bg_minimize = theme.xcolor8

theme.fg_normal = theme.xcolor8
theme.fg_focus = theme.xcolor4
theme.fg_urgent = theme.xcolor3
theme.fg_minimize = theme.xcolor8

-- Gaps
theme.useless_gap = dpi(15)

-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(4)

-- Borders
theme.border_width = 0
theme.border_color = "#171719"
theme.border_normal = theme.border_color
theme.border_focus = theme.border_color

-- Rounded corners
theme.border_radius = dpi(5)

-- Titlebars
-- (Titlebar items can be customized in titlebars.lua)
theme.titlebars_enabled = true
theme.titlebar_size = dpi(26)
theme.titlebar_title_enabled = false
theme.titlebar_font = "IBM Plex Sans 9"
theme.titlebar_title_align = "Left"
theme.titlebar_position = "top"
theme.titlebars_imitate_borders = false
theme.titlebar_bg = theme.xcolor0
theme.titlebar_fg_focus = theme.xbackground
theme.titlebar_fg_normal = theme.xcolor8
theme.titlebar_fg = theme.xcolor7

-- Notifications
-- ============================
theme.notification_position = "top_right"
theme.notification_border_width = dpi(0)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = theme.xforeground .. "15"
theme.notification_bg = theme.xbackground .. "dd"
theme.notification_fg = theme.xforeground
theme.notification_crit_bg = theme.xbackground
theme.notification_crit_fg = theme.xcolor1
theme.notification_icon_size = dpi(60)
theme.notification_margin = dpi(20)
theme.notification_opacity = 1
theme.notification_font = "IBM Plex Sans 12"
theme.notification_padding = theme.screen_margin * 2
theme.notification_spacing = theme.screen_margin * 2

-- Edge snap
theme.snap_shape = gears.shape.rectangle
theme.snap_bg = theme.xforeground
theme.snap_border_width = dpi(3)

-- Tag names
theme.tagnames = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0"
}

-- Widget separator
theme.separator_text = "|"
--theme.separator_text = " :: "
--theme.separator_text = " • "
-- theme.separator_text = " •• "
theme.separator_fg = theme.xcolor8

-- Wibar(s)
-- (Bar items can be customized in bar_themes/<bar_theme>.lua)
-- Keep in mind that these settings could be ignored by the bar theme
theme.wibar_position = "top"
theme.wibar_height = dpi(24)
theme.wibar_fg = theme.xcolor7
theme.wibar_bg = theme.xbackground
theme.wibar_opacity = 1
theme.wibar_border_color = theme.xcolor0
theme.wibar_border_width = dpi(0)
theme.wibar_border_radius = dpi(0)
theme.wibar_width = dpi(700)

theme.prefix_fg = theme.xcolor8

-- Exit screen
theme.exit_screen_bg = theme.xcolor0 .. "66"
theme.exit_screen_fg = theme.xcolor7
theme.exit_screen_font = "sans 16"
theme.exit_screen_icon_size = dpi(70)

-- Lock screen
theme.lock_screen_bg = theme.xcolor0 .. "CC"
theme.lock_screen_fg = theme.xcolor7

-- Icon taglist
local ntags = 10
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}

-- Noodle Text Taglist
theme.taglist_text_font = "icomoon 15"

-- theme.taglist_text_font = "sans bold 15"
theme.taglist_text_empty = {"", "", "", "", "", "", "", "", "", ""}
theme.taglist_text_occupied = {"", "", "", "", "", "", "", "", "", ""}
theme.taglist_text_focused = {"", "", "", "", "", "", "", "", "", ""}
theme.taglist_text_urgent = {"+", "+", "+", "+", "+", "+", "+", "+", "+", "+"}

theme.taglist_text_color_empty = {
    theme.xforeground .. "60",
    theme.xforeground .. "60",
    theme.xforeground .. "60",
    theme.xforeground .. "60",
    theme.xforeground .. "60",
    theme.xforeground .. "60",
    theme.xforeground .. "60",
    theme.xforeground .. "60",
    theme.xforeground .. "60",
    theme.xforeground .. "60"
}

theme.taglist_text_color_occupied = {
    theme.xcolor1,
    theme.xcolor2,
    theme.xcolor3,
    theme.xcolor4,
    theme.xcolor5,
    theme.xcolor6,
    theme.xcolor1,
    theme.xcolor2,
    theme.xcolor3,
    theme.xcolor4
}
theme.taglist_text_color_focused = {
    theme.xcolor1,
    theme.xcolor2,
    theme.xcolor3,
    theme.xcolor4,
    theme.xcolor5,
    theme.xcolor6,
    theme.xcolor1,
    theme.xcolor2,
    theme.xcolor3,
    theme.xcolor4
}
theme.taglist_text_color_urgent = {
    theme.xcolor7,
    theme.xcolor7,
    theme.xcolor7,
    theme.xcolor7,
    theme.xcolor7,
    theme.xcolor7,
    theme.xcolor7,
    theme.xcolor7,
    theme.xcolor7,
    theme.xcolor7
}

-- Prompt
theme.prompt_fg = theme.xcolor12

-- Text Taglist (default)
theme.taglist_font = "monospace bold 9"
theme.taglist_bg_focus = theme.xbackground
theme.taglist_fg_focus = theme.xcolor12
theme.taglist_bg_occupied = theme.xbackground
theme.taglist_fg_occupied = theme.xcolor8
theme.taglist_bg_empty = theme.xbackground
theme.taglist_fg_empty = theme.xbackground
theme.taglist_bg_urgent = theme.xbackground
theme.taglist_fg_urgent = theme.xcolor3
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(0)
theme.taglist_item_roundness = dpi(25)
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_focus)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming the menu:
theme.menu_height = dpi(35)
theme.menu_width = dpi(180)
theme.menu_bg_normal = theme.xcolor0
theme.menu_fg_normal = theme.xcolor7
theme.menu_bg_focus = theme.xcolor8 .. "55"
theme.menu_fg_focus = theme.xcolor7
theme.menu_border_width = dpi(0)
theme.menu_border_color = theme.xcolor0
theme.tasklist_fg_normal = theme.xforeground .. "77"
theme.tasklist_fg_focus = theme.xforeground .. "ff"
theme.tasklist_font = "IBM Plex Sans 9"
theme.tasklist_disable_icon = true
theme.tasklist_plain_task_name = true

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Numix"

return theme
