local micDevice = nil
local micDeviceInUse = false

local micCheckHandlers = {}

local function micCheck(force)
    local inUse = micDevice:inUse()
    if not force and inUse == micDeviceInUse then
        return
    end
    micDeviceInUse = inUse
    
    for _, handler in pairs(micCheckHandlers) do
        handler(inUse)
    end
end

local function micCheckCb()
    micCheck(false)
end

local function micChangeCheck()
    local newDevice = hs.audiodevice.defaultInputDevice()
    if newDevice == micDevice then
        micCheckCb()
        return
    end

    if micDevice then
        micDevice:watcherStop()
        micDevice:watcherCallback(nil)
    end

    micDevice = newDevice

    micDevice:watcherCallback(micCheckCb)
    micDevice:watcherStart()

    micCheck(true)
end

local M = {}
function M.start()
    hs.audiodevice.watcher.setCallback(micChangeCheck)
    hs.audiodevice.watcher.start()
    M.check()
end
function M.check()
    micChangeCheck()
end
function M.addHandler(fn)
    table.insert(micCheckHandlers, fn)
end
function M.removeHandler(fn)
    local idx = -1
    for i, handler in pairs(micCheckHandlers) do
        if handler == fn then
            idx = i
            break
        end
    end
    if idx > 0 then
        table.remove(micCheckHandlers, idx)
    end
end
function M.stop()
    hs.audiodevice.watcher.stop()
    hs.audiodevice.watcher.setCallback(nil)
    if micDevice then
        micDevice:watcherStop()
        micDevice:watcherCallback(nil)
    end
end
return M
