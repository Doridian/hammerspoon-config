local dock, homeassistant, microphone

local function dockHandler(isDocked, isEvent)
    if isDocked then
        homeassistant.switch("switch.dori_pc_relay", true)
    end
end


local micLastInUse = false
local micLightState = nil

local MIC_LIGHT_ID = "light.ceiling_office_entrance_light"

local function micHandler(inUse)
    if not dock.isDocked() then
        inUse = false
    end

    if inUse == micLastInUse then
        return
    end
    micLastInUse = inUse

    if inUse then
        homeassistant.state(MIC_LIGHT_ID, function(state)
            if not state then
                return
            end

            micLightState = state

            homeassistant.control("light", MIC_LIGHT_ID, "turn_on", {
                color_name = "red",
                brightness_pct = 40,
            })
        end)
    elseif micLightState then
        local attrs = micLightState.attributes
        if micLightState.state == "off" then
            homeassistant.control("light", MIC_LIGHT_ID, "turn_off")
        elseif attrs.color_mode == "xy" then
            homeassistant.control("light", MIC_LIGHT_ID, "turn_on", {
                xy_color = attrs.xy_color,
                brightness = attrs.brightness,
            })
        elseif attrs.color_mode == "color_temp" then
            homeassistant.control("light", MIC_LIGHT_ID, "turn_on", {
                color_temp = attrs.color_temp,
                brightness = attrs.brightness,
            })
        elseif attrs.color_mode == "rgb" then
            homeassistant.control("light", MIC_LIGHT_ID, "turn_on", {
                rgb_color = attrs.rgb_color,
                brightness = attrs.brightness,
            })
        end
        micLightState = nil
    end
end

local function ctor()
    dock = require("dock")
    homeassistant = require("homeassistant")
    microphone = require("microphone")

    dock.addHandler(dockHandler)
    microphone.addHandler(micHandler)
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
    load = {"dock", "kbdlight", "mediakeys", "microphone"},
    ctor = ctor,
}
