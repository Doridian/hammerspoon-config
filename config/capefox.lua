return {
    screens = {
        ["LG ULTRAGEAR"] = {
            mode = {
                w = 2560,
                h = 1440,
                scale = 1.0,
                freq = 120,
            },
            origin = {
                x = -2560,
                y = 0,
            },
        },
        ["LG HDR WQHD+"] = {
            mode = {
                w = 3840,
                h = 1600,
                scale = 1.0,
                freq = 120,
            },
            origin = {
                x = 0,
                y = 0,
            },
        },
    },
    windowalign = {
        default = {
            margins = {
                x = 0,
                y = 0,
            },
            screens = {
                main = {
                    find = "LG HDR WQHD+",
                    w = 2,
                    h = 2,
                },
                side = {
                    find = "LG ULTRAGEAR",
                    w = 2,
                    h = 2,
                },
                builtin = {
                    find = "Built%-in",
                    w = 2,
                    h = 2,
                },
            },
        },
        docked = {
            windows = {
                {
                    find = "Mail",
                    screen = "side",
                    x = 0,
                    y = 0,
                    w = 1,
                    h = 1,
                },
                {
                    find = "Music",
                    screen = "side",
                    x = 1,
                    y = 0,
                    w = 1,
                    h = 1,
                },
                {
                    find = "Telegram",
                    screen = "side",
                    x = 0,
                    y = 1,
                    w = 1,
                    h = 1,
                },
                {
                    find = "Discord Canary",
                    screen = "side",
                    x = 1,
                    y = 1,
                    w = 1,
                    h = 1,
                },
                {
                    find = "Google Chrome",
                    screen = "main",
                    x = 0,
                    y = 0,
                    w = 2,
                    h = 2,
                },
            },
        },
        undocked = {
            windows = {
                {
                    find = "Mail",
                    screen = "builtin",
                    x = 0,
                    y = 0,
                    w = 1,
                    h = 1,
                },
                {
                    find = "Music",
                    screen = "builtin",
                    x = 1,
                    y = 0,
                    w = 1,
                    h = 1,
                },
                {
                    find = "Telegram",
                    screen = "builtin",
                    x = 0,
                    y = 1,
                    w = 1,
                    h = 1,
                },
                {
                    find = "Discord Canary",
                    screen = "builtin",
                    x = 1,
                    y = 1,
                    w = 1,
                    h = 1,
                },
                {
                    find = "Google Chrome",
                    screen = "builtin",
                    x = 0,
                    y = 0,
                    w = 2,
                    h = 2,
                },
            },
        },
    },
    dock = {
        vendorID = 0x2188,
        productID = 0x0034,
    },
    load = {"screens", "dock"},
    ctor = function()
        local dock = require("dock")
        local homeassistant = require("homeassistant")
        local windowalign = require("windowalign")
        dock.addHandler(function(isDocked)
            if isDocked then
                homeassistant.switch("switch.dori_pc_relay", true)
                windowalign.load("docked")
            else
                windowalign.load("undocked")
            end
        end)
    end,
}
