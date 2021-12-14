local config = require("config").get("windowalign")

local M = {}
function M.load(name)
    local layout = config[name]

    if layout.margins then
        hs.grid.setMargins(layout.margins)
    end

    local screens = {}

    for id, screenConfig in pairs(layout.screens) do
        local screen = hs.screen.find(screenConfig.find)
        if screen then
            screens[id] = screen
            hs.grid.setGrid(screenConfig, screen)
        end
    end

    for _, windowConfig in pairs(layout.windows) do
        local screen = screens[windowConfig.screen]
        if screen then
            local windows = hs.window.filter.new(windowConfig.find):getWindows()
            for _, window in pairs(windows) do
                hs.grid.set(window, windowConfig, screen)
            end
        end
    end
end
return M