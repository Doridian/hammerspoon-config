
-- Detect when screens are in states they shouldn't be
local screenConfigTable = require("config").get("screens")

local function screenResolutionWatcherFn()
    local screens = hs.screen.allScreens()

    local fixScreenModes = {}
    local fixScreenOrigins = {}

    for _, screen in pairs(screens) do
        local name = screen:name()
        local shouldConfig = screenConfigTable[name]
        if shouldConfig then
            local isMode = screen:currentMode()
            for param, val in pairs(shouldConfig.mode) do
                if isMode[param] ~= val then
                    print("Mismatch on ", name, " ", param, " (is ", isMode[param], "; should be ", val, ")")
                    fixScreenModes[screen] = shouldConfig.mode
                end
            end

            local isOrigin = screen:localToAbsolute({x = 0, y = 0})
            if isOrigin.x ~= shouldConfig.origin.x or isOrigin.y ~= shouldConfig.origin.y then
                fixScreenOrigins[screen] = shouldConfig.origin
            end
        end
    end
    for screen, mode in pairs(fixScreenModes) do
        local isMode = screen:currentMode()
        local ok = screen:setMode(mode.w or isMode.w, mode.h or isMode.h, mode.scale or isMode.scale, mode.freq or isMode.freq, mode.depth or isMode.depth)
        if not ok then
            hs.alert.show("This screen is running a wrong mode!", {}, screen, 15)
        end
    end
    for screen, origin in pairs(fixScreenOrigins) do
        local ok = screen:setOrigin(origin.x, origin.y)
        if not ok then
            hs.alert.show("This screen is at the wrong position!", {}, screen, 15)
        end
    end
end

local screenResolutionWatcher
local M = {}
function M.start()
    M.stop()
    screenResolutionWatcher = hs.screen.watcher.new(screenResolutionWatcherFn)
    screenResolutionWatcher:start()
    screenResolutionWatcherFn()
end

function M.stop()
    if screenResolutionWatcher then
        screenResolutionWatcher:stop()
        screenResolutionWatcher = nil
    end
end
return M
