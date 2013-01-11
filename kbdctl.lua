local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local os = require("os")
module("kbdctl")
-- Keyboard config
cmd = "setxkbmap"
local layout = { "us", "ru" }
local current = 1  -- us is our default layout
widget = wibox.widget.textbox({name = "kbdwidget"}) 
widget.border_width = 1
widget.border_color = beautiful.fg_normal 
widget:set_text(" " .. layout[current] .. " ")
switch = function ()
    current = current % #(layout) + 1
    local t = " " .. layout[current] .. " "
    widget:set_text(t)
    os.execute( cmd .. t )
end

-- Mouse bindings
widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () switch() end)
))
