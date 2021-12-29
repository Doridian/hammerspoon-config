local config = require("config").get("windowalign")

local M = {}
function M.load(name)
    print("Loading windowalign", name)
    local layout = config[name]

    if layout.margins or config.default.margins then
        hs.grid.setMargins(layout.margins or config.default.margins)
    end

    local screens = {}

    for id, screenConfig in pairs(layout.screens or config.default.screens) do
        local screen = hs.screen.find(screenConfig.find)
        if screen then
            screens[id] = screen
            hs.grid.setGrid(screenConfig, screen)
        end
    end

    local windowConfigs = layout.windows or config.default.windows
    for _, window in pairs(hs.window.visibleWindows()) do
        local windowConfig = windowConfigs[window:application():name()]
        if windowConfig then
            local screen = screens[windowConfig.screen]
            if screen then
                hs.grid.set(window, windowConfig, screen)
            end
        end
    end
end
return M
