
-- Detect when screens are in states they shouldn't be
local screenConfigTable = require("config").get("screens")

local screenStateHandlers = {}
local function screenResolutionWatcherFnInt(isEvent)
    local screens = hs.screen.allScreens()

    local fixScreenModes = {}
    local fixScreenOrigins = {}
    local makeScreenPrimary
    local makeScreenPrimaryPrio = -1

    for _, screen in pairs(screens) do
        local name = screen:name()
        local shouldConfig = screenConfigTable[name]
        if shouldConfig then
            if shouldConfig.mode then
                local isMode = screen:currentMode()
                for param, val in pairs(shouldConfig.mode) do
                    if isMode[param] ~= val then
                        print("Mismatch on ", name, " ", param, " (is ", isMode[param], "; should be ", val, ")")
                        fixScreenModes[screen] = shouldConfig.mode
                    end
                end
            end

            if shouldConfig.origin then
                local isOrigin = screen:localToAbsolute({x = 0, y = 0})
                if isOrigin.x ~= shouldConfig.origin.x or isOrigin.y ~= shouldConfig.origin.y then
                    fixScreenOrigins[screen] = shouldConfig.origin
                end
            end

            if shouldConfig.primary and makeScreenPrimaryPrio < shouldConfig.primary then
                makeScreenPrimaryPrio = shouldConfig.primary
                makeScreenPrimary = screen
            end
        end
    end

    if makeScreenPrimary and makeScreenPrimary ~= hs.screen.primaryScreen() then
        local ok = makeScreenPrimary:setPrimary()
        if not ok then
            hs.alert.show("This screen is not primary!", {}, makeScreenPrimary, 15)
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

    for _, handler in pairs(screenStateHandlers) do
        handler(isEvent)
    end
end
local function screenResolutionWatcherFn()
    screenResolutionWatcherFnInt(true)
end

local screenResolutionWatcher
local M = {}
function M.start()
    M.stop()
    screenResolutionWatcher = hs.screen.watcher.new(screenResolutionWatcherFn)
    screenResolutionWatcher:start()
    M.check()
end
function M.check()
    screenResolutionWatcherFnInt(false)
end
function M.stop()
    if screenResolutionWatcher then
        screenResolutionWatcher:stop()
        screenResolutionWatcher = nil
    end
end
function M.addHandler(fn)
    table.insert(screenStateHandlers, fn)
end
function M.removeHandler(fn)
    local idx = -1
    for i, handler in pairs(screenStateHandlers) do
        if handler == fn then
            idx = i
            break
        end
    end
    if idx > 0 then
        table.remove(screenStateHandlers, idx)
    end
end
return M
