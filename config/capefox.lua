return {
    screens = {
        ["LG ULTRAGEAR"] = {
            mode = {
                w = 2560,
                h = 1440,
                scale = 1.0,
                freq = 120,
            },
            primary = 1,
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
            primary = 2,
            origin = {
                x = 0,
                y = 0,
            },
        },
        ["Built%-in"] = {
            primary = 0,
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
                    w = 1,
                    h = 1,
                },
                side = {
                    find = "LG ULTRAGEAR",
                    w = 12,
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
                    w = 4,
                    h = 1,
                },
                {
                    find = "Deliveries",
                    screen = "side",
                    x = 4,
                    y = 0,
                    w = 3,
                    h = 1,
                },
                {
                    find = "Music",
                    screen = "side",
                    x = 7,
                    y = 0,
                    w = 5,
                    h = 1,
                },
                {
                    find = "Spotify",
                    screen = "side",
                    x = 7,
                    y = 0,
                    w = 5,
                    h = 1,
                },
                {
                    find = "Telegram",
                    screen = "side",
                    x = 0,
                    y = 1,
                    w = 6,
                    h = 1,
                },
                {
                    find = "Discord Canary",
                    screen = "side",
                    x = 6,
                    y = 1,
                    w = 6,
                    h = 1,
                },
                {
                    find = "Google Chrome",
                    screen = "main",
                    x = 0,
                    y = 0,
                    w = 1,
                    h = 1,
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
                    find = "Spotify",
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
    audiodevice = {
        ["Schiit Unison Modius (eqMac)"] = {
            priority = 4,
            volume = 100,
        },
        ["Schiit Unison Modius"] = {
            priority = 3,
        },
        ["MacBook Pro Speakers (eqMac)"] = {
            priority = 2,
        },
        ["MacBook Pro Speakers"] = {
            priority = 1,
        },
    },
    load = {"screens", "dock", "audiodevice", "kbdlight"},
    ctor = function()
        local dock = require("dock")
        local screens = require("screens")
        local homeassistant = require("homeassistant")
        local windowalign = require("windowalign")
        local function applyTheme()
            if dock.isDocked() then
                windowalign.load("docked")
            else
                windowalign.load("undocked")
            end
        end
        screens.addHandler(applyTheme)
        dock.addHandler(applyTheme)
        dock.addHandler(function(isDocked)
            if isDocked then
                homeassistant.switch("switch.dori_pc_relay", true)
            end
        end)
    end,
}
