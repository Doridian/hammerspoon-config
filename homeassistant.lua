local secrets = require("config").getSecret("homeassistant")
local headers = {
    Authorization = "Bearer " .. secrets.token,
    ["Content-Type"] = "application/json",
}

local M = {}

function M.control(cls, id, control, data)
    if not data then
        data = {}
    end
    data.entity_id = id

    hs.http.asyncPost(secrets.url .. "/api/services/" .. cls .. "/" .. control, hs.json.encode(data), headers, function(status, body, responseHeaders)
        if status == 200 then
            return
        end
        print("HASS control = ", status, body)
    end)
end

function M.state(id, cb)
    hs.http.asyncGet(secrets.url .. "/api/states/" .. id, headers, function(status, body, responseHeaders)
        if status ~= 200 then
            print("HASS state = ", status, body)
            cb(nil)
            return
        end

        cb(hs.json.decode(body))
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
