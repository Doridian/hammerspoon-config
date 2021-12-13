local secrets = require("config").get_secret("homeassistant")
local headers = {
    Authorization = "Bearer " .. secrets.token,
    ["Content-Type"] = "application/json",
}

local M = {}
function M.control(cls, id, control)
    local data = hs.json.encode({
        entity_id = id,
    })
    hs.http.asyncPost(secrets.url .. "/api/services/" .. cls .. "/" .. control, data, headers, function(status, body, responseHeaders)
        if status == 200 then
            return
        end
        print("HASS control = ", status, body)
    end)
end
function M.switch(id, on)
    local control = "turn_off"
    if on then
        control = "turn_on"
    end
    return M.control("switch", id, control)
end
return M
