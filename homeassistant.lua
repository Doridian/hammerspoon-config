local config = require("config")
HOMEASSISTANT_TOKEN = config.get_secret("homeassistant").token
HOMEASSISTANT_URL = config.get_secret("homeassistant").url

local M = {}
function M.control(cls, id, control)
    local headers = {
        Authorization = "Bearer  " .. HOMEASSISTANT_TOKEN
    }
    local data = hs.json.encode({
        entity_id = id,
    })
    print("HS control = ", hs.http.post(HOMEASSISTANT_URL .. "/api/services/" .. cls .. "/" .. control, data, headers))
end
function M.switch(id, on)
    local control = "turn_off"
    if on then
        control = "turn_on"
    end
    return homeassistant_control("switch", id, control)
end
return M
