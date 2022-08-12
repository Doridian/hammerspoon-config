local dock, homeassistant

local function dockHandler(isDocked, isEvent)
    if isDocked then
        homeassistant.switch("switch.dori_pc_relay", true)
    end
end

local function ctor()
    dock = require("dock")
    homeassistant = require("homeassistant")

    dock.addHandler(dockHandler)
end

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
                Mail = {
                    screen = "side",
                    x = 0,
                    y = 0,
                    w = 4,
                    h = 1,
                },
                Deliveries = {
                    screen = "side",
                    x = 4,
                    y = 0,
                    w = 3,
                    h = 1,
                },
                Reminders = {
                    screen = "side",
                    x = 4,
                    y = 0,
                    w = 3,
                    h = 1,
                },
                Music = {
                    screen = "side",
                    x = 7,
                    y = 0,
                    w = 5,
                    h = 1,
                },
                Spotify = {
                    screen = "side",
                    x = 7,
                    y = 0,
                    w = 5,
                    h = 1,
                },
                Telegram = {
                    screen = "side",
                    x = 0,
                    y = 1,
                    w = 6,
                    h = 1,
                },
                ["Discord Canary"] = {
                    screen = "side",
                    x = 6,
                    y = 1,
                    w = 6,
                    h = 1,
                },
                Discord = {
                    screen = "side",
                    x = 6,
                    y = 1,
                    w = 6,
                    h = 1,
                },
                Safari = {
                    screen = "main",
                    x = 0,
                    y = 0,
                    w = 1,
                    h = 1,
                },
                ["Google Chrome"] = {
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
                Mail = {
                    screen = "builtin",
                    x = 0,
                    y = 0,
                    w = 1,
                    h = 1,
                },
                Music = {
                    screen = "builtin",
                    x = 1,
                    y = 0,
                    w = 1,
                    h = 1,
                },
                Spotify = {
                    screen = "builtin",
                    x = 1,
                    y = 0,
                    w = 1,
                    h = 1,
                },
                Telegram = {
                    screen = "builtin",
                    x = 0,
                    y = 1,
                    w = 1,
                    h = 1,
                },
                Discord = {
                    screen = "builtin",
                    x = 1,
                    y = 1,
                    w = 1,
                    h = 1,
                },
                ["Discord Canary"] = {
                    screen = "builtin",
                    x = 1,
                    y = 1,
                    w = 1,
                    h = 1,
                },
                ["Google Chrome"] = {
                    screen = "builtin",
                    x = 0,
                    y = 0,
                    w = 2,
                    h = 2,
                },
                Safari = {
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
    mediakeys = {
        player = "spotify",
    },
    load = {"dock", "kbdlight", "mediakeys"},
    ctor = ctor,
}
