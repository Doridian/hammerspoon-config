local config = require("config")

local modules = {}
for _, name in pairs(config.get("load")) do
    print("Loading module ", name)
    modules[name] = require(name)
end

local ctor = config.get("ctor")
if ctor then
    ctor()
end

for name, mod in pairs(modules) do
    if mod.start then
        print("Starting module ", name)
        mod.start()
    end
end

local function globalReCheck()
    for name, mod in pairs(modules) do
        if mod.check then
            print("Re-check module ", name)
            mod.check()
        end
    end
end
hs.hotkey.bind({"ctrl","alt","cmd"}, "k", "Global re-check started", globalReCheck)
