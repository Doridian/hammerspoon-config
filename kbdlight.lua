local evttap

local function handleEvent(event)
    local keyEvent = event:systemKey()
    local keyFlags = event:getFlags()
    if not keyEvent or not keyEvent.key or not keyEvent.down or not keyFlags or not keyFlags:containExactly({"cmd"}) then
        return false
    end

    local newEventKey
    if keyEvent.key == "BRIGHTNESS_UP" then
        newEventKey = "ILLUMINATION_UP"
    elseif keyEvent.key == "BRIGHTNESS_DOWN" then
        newEventKey = "ILLUMINATION_DOWN"
    end
    if not newEventKey then
        return false
    end
    
    local newEvent = hs.eventtap.event.newSystemKeyEvent(newEventKey, true)
    local newEvent2 = hs.eventtap.event.newSystemKeyEvent(newEventKey, false)
    return true, {newEvent, newEvent2}
end

local M = {}
function M.start()
    M.stop()
    evttap = hs.eventtap.new({hs.eventtap.event.types.systemDefined}, handleEvent)
    evttap:start()
end
function M.stop()
    if evttap then
        evttap:stop()
        evttap = nil
    end
end
return M
