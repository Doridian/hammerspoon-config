local dock, homeassistant

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
