local secrets = require("config").get_secret("homeassistant")
local headers = {
    Authorization = "Bearer " .. secrets.token
}
headers["Content-Type"] = "application/json"

local M = {}
function M.control(cls, id, control)
    local data = hs.json.encode({
        entity_id = id,
    })
    print("HS control = ", hs.http.post(secrets.url .. "/api/services/" .. cls .. "/" .. control, data, headers))
end
function M.switch(id, on)
    local control = "turn_off"
    if on then
        control = "turn_on"
    end
    return M.control("switch", id, control)
end
return M
