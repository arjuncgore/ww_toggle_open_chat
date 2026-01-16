-- ==== VARS ====
local waywall = require("waywall")
--
-- local cfg = {
--     key = "MB5",
--     chat_func = "Home"
--     norm_func = "F13"
-- }

local M       = {}
-- ==== PLUG ====
M.setup       = function(config, cfg)
    local remaps_norm = {} -- No Chat
    local remaps_chat = {} -- Yes Chat
    for key, val in pairs(config.input.remaps) do
        remaps_norm[key] = val
        remaps_chat[key] = val
    end

    if remaps_norm[cfg.key] ~= cfg.chat_func then
        remaps_chat[cfg.key] = cfg.chat_func
    end
    remaps_norm[cfg.key] = cfg.norm_func

    waywall.listen("state", function()
        local state = waywall.state()
        if state.screen == "inworld" and state.inworld == "unpaused" then
            waywall.set_remaps(remaps_norm)
        else
            waywall.set_remaps(remaps_chat)
        end
    end)
end

return M
