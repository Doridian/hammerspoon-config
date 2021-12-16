local audioDeviceTable = require("config").get("audiodevice")

local function audioDeviceCheck()
    local currentDevice = hs.audiodevice.defaultOutputDevice()

    local newDevice
    local newDevicePrio = -1

    for _, dev in pairs(hs.audiodevice.allDevices()) do
        local name = dev:name()

        local deviceTable = audioDeviceTable[name]
        if deviceTable and deviceTable.priority > newDevicePrio then
            newDevice = dev
        end
    end

    if newDevice then
        newDevice:setDefaultOutputDevice()
        newDevice:setDefaultEffectDevice()
        currentDevice = newDevice
    end

    local deviceTable = audioDeviceTable[currentDevice:name()]
    if deviceTable and deviceTable.volume then
        currentDevice:setOutputVolume(deviceTable.volume)
    end
end

local M = {}
function M.start()
    hs.audiodevice.watcher.setCallback(audioDeviceCheck)
    hs.audiodevice.watcher.start()
    audioDeviceCheck()
end
function M.stop()
    hs.audiodevice.watcher.stop()
    hs.audiodevice.watcher.setCallback(nil)
end
return M