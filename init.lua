local config = require("config")

local to_load = config.get("load")

local modules = {}
for _, name in pairs(config.get("load")) do
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
