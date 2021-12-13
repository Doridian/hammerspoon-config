local data = require("config." .. hs.host.localizedName():lower())
local secrets = require("config.secrets")

local M = {}
function M.get(key)
    return data[key]
end
function M.get_secret(key)
    return secrets[key]
end
return M
