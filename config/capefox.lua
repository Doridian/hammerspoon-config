local dock, screens, homeassistant, windowalign

local function applyTheme()
    if dock.isDocked() then
        windowalign.load("docked")
    else
        windowalign.load("undocked")
    end
end

local function screensHandler(isEvent, hasChanges)
    if isEvent and hasChanges then
        applyTheme()
    end
end

local function dockHandler(isDocked, isEvent)
    if isDocked then
        homeassistant.switch("switch.dori_pc_relay", true)
    end
    if isEvent then
        applyTheme()
    end
end

local function ctor()
    dock = require("dock")
    screens = require("screens")
    homeassistant = require("homeassistant")
    windowalign = require("windowalign")

    screens.addHandler(screensHandler)
    dock.addHandler(dockHandler)
end

local function check()
    applyTheme()
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
    audiodevice = {
        ["Schiit Unison Modius (eqMac)"] = {
            priority = 2,
            volume = 100,
        },
        ["Schiit Unison Modius"] = {
            priority = 2,
        },
        ["Scarlett Solo USB (eqMac)"] = {
            priority = 2,
            volume = 100,
        },
        ["Scarlett Solo USB"] = {
            priority = 2,
        },
        ["MacBook Pro Speakers (eqMac)"] = {
            priority = 1,
        },
        ["MacBook Pro Speakers"] = {
            priority = 1,
        },
    },
    mediakeys = {
        player = "music",
    },
    load = {"screens", "dock", "audiodevice", "kbdlight", "mediakeys"},
    ctor = ctor,
    check = check,
}
