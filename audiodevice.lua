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
            newDevicePrio = deviceTable.priority
        end
    end

    local deviceTable = audioDeviceTable[currentDevice:name()]
    if newDevice and deviceTable and deviceTable.priority < newDevicePrio then
        newDevice:setDefaultOutputDevice()
        newDevice:setDefaultEffectDevice()
        currentDevice = newDevice
    end

    deviceTable = audioDeviceTable[currentDevice:name()]
    if deviceTable and deviceTable.volume then
        currentDevice:setOutputVolume(deviceTable.volume)
    end
end

local M = {}
function M.start()
    hs.audiodevice.watcher.setCallback(audioDeviceCheck)
    hs.audiodevice.watcher.start()
    M.check()
end
function M.check()
    audioDeviceCheck()
end
function M.stop()
    hs.audiodevice.watcher.stop()
    hs.audiodevice.watcher.setCallback(nil)
end
return M
