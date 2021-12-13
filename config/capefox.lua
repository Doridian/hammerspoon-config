return {
    screens = {
        ["LG ULTRAGEAR"] = {
            mode = {
                w = 2560,
                h = 1440,
                scale = 1.0,
                freq = 120,
                depth = 8,
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
                depth = 8,
            },
            origin = {
                x = 0,
                y = 0,
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
        dock.addHandler(function(isDocked)
            if isDocked then
                homeassistant.switch("switch.dori_pc_relay", true)
            end
        end)
    end,
}
