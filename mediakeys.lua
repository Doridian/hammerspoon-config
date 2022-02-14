local evttap, mpintf
local mediaKeysConfig = require("config").get("mediakeys")

local MEDIA_KEY_MAP = {
    PLAY = function()
        mpintf.playpause()
    end,
    PREVIOUS = function()
        mpintf.previous()
    end,
    NEXT = function()
        mpintf.next()
    end,
    FAST = function()
        mpintf.next()
    end,
    REWIND = function()
        mpintf.previous()
    end,
}

local function handleEvent(event)
    if not mpintf then
        return false
    end

    local keyEvent = event:systemKey()
    if not keyEvent or not keyEvent.key then
        return false
    end

    local func = MEDIA_KEY_MAP[keyEvent.key]
    if not func then
        return false
    end

    if keyEvent.down then
        pcall(func)
    end
    return true
end

local M = {}
function M.start()
    local player = mediaKeysConfig.player:lower()
    if player == "spotify" then
        mpintf = hs.spotify
    elseif player == "itunes" or player == "music" or player == "apple" or player == "apple music" or player == "applemusic" then
        mpintf = hs.itunes
    end
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
