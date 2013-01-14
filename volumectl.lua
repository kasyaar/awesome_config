local cli = require("cli")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
module("volumectl")

-- volumectl = {}
local getvol = function () 
    return cli.run(awful.util.getdir("config") .. "/getvol")
end
local getactivesink = awful.util.getdir("config") .. "/getactivesink"
--[[ function debug_awesome(message)
    naughty.notify({ preset = naughty.config.presets.critical,
    title = message,
    text = err })
end ]]

widget = wibox.widget.textbox({name = "volumewidget"}) 
widget.border_width = 1
widget.border_color = beautiful.fg_normal 
widget:set_text(" Vol: ["..getvol().." ] ")
local cmd = "pactl"
local mute_state = 0
mute = function ()
    local activesink = cli.run(getactivesink) 
    if mute_state == 0 then
        awful.util.spawn(cmd .. " set-sink-mute " .. activesink .. " 1")
        mute_state = 1
        widget:set_text(" Vol: [MUTE: "..getvol().." ] ")
    else
        awful.util.spawn(cmd .. " set-sink-mute " .. activesink .. "  0")
        mute_state = 0
        widget:set_text(" Vol: ["..getvol().." ] ")
    end
end
local update_widget = function ()
    local volume = getvol()
    widget:set_text(" Vol: ["..volume.." ] ")
    naughty.notify({ preset = naughty.config.presets.low,
                     title = "Volume changed",
                     text = volume })
end
inc = function ()
    local activesink = cli.run(getactivesink) 
    awful.util.spawn(cmd .. " set-sink-volume " .. activesink .. "   -- +5%")
    update_widget()
end
dec = function ()
    local activesink = cli.run(getactivesink) 
    awful.util.spawn(cmd .. " set-sink-volume " .. activesink .. " -- -5%")
    update_widget()
end
