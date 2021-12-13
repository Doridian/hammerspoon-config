-- Detect when we do and undock
local config = require("config").get("dock")

local isDocked = nil
local dockStateHandlers = {}
local function dockStateDispatcher(newIsDocked, isEvent)
    if isDocked == newIsDocked then
        return
    end
    isDocked = newIsDocked
    for _, handler in pairs(dockStateHandlers) do
        handler(isDocked, isEvent)
    end
end
local function usbWatcherFn(event)
    if event.vendorID == config.vendorID and event.productID == config.productID then
        dockStateDispatcher(event.eventType == "added", true)
    end
end

local function activeDockCheck()
    local dockFound = false
    for _, dev in pairs(hs.usb.attachedDevices()) do
        if dev.vendorID == config.vendorID and dev.productID == config.productID then
            dockStateDispatcher(true, false)
            dockFound = true
            break
        end
    end
    if not dockFound then
        dockStateDispatcher(false, false)
    end
end

local usbWatcher
local M = {}
function M.start()
    M.stop()
    usbWatcher = hs.usb.watcher.new(usbWatcherFn)
    usbWatcher:start()
    activeDockCheck()
end
function M.stop()
    if usbWatcher then
        usbWatcher:stop()
        usbWatcher = nil
    end
end
function M.add_handler(fn)
    table.insert(dockStateHandlers, fn)
end
function M.remove_handler(fn)
    local idx = -1
    for i, handler in pairs(dockStateHandlers) do
        if handler == fn then
            idx = i
            break
        end
    end
    if idx > 0 then
        table.remove(dockStateHandlers, idx)
    end
end
function M.is_docked()
    return isDocked
end
return M
