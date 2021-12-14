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
        docked = {
            margins = {
                x = 0,
                y = 0,
            },
            screens = {
                main = {
                    find = "LG HDR WQHD+",
                    w = 3,
                    h = 3,
                },
                side = {
                    find = "LG ULTRAGEAR",
                    w = 2,
                    h = 2,
                },
            },
            windows = {
                {
                    find = "Google Chrome",
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
                    find = "Google Chrome 2",
                    screen = "main",
                    x = 0,
                    y = 0,
                    w = 3,
                    h = 3,
                },
            },
        },
        undocked = {

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
        dock.addHandler(function(isDocked)
            if isDocked then
                homeassistant.switch("switch.dori_pc_relay", true)
            end
        end)
    end,
}
