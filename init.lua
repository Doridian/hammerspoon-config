local screens = require("screens")
local dock = require("dock")
local homeassistant = require("homeassistant")

dock.add_handler(function(isDocked)
    if isDocked then
        
    end
end)

screens.start()
dock.start()
