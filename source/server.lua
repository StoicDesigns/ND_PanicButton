-- Utility function to get Discord roles for a player
    local function getDiscordRoles(playerSource)
        local roles = exports.Badger_Discord_API:GetDiscordRoles(playerSource)  -- Fetch Discord roles
        return roles or {}
    end
    
    -- Handle panic command
    if config["panic"].enabled then
        RegisterCommand("panic", function(source, args, rawCommand)
            local playerPed = GetPlayerPed(source)
            local playerCoords = GetEntityCoords(playerPed)
    
            -- Get Discord roles for the player
            local playerRoles = getDiscordRoles(source)
            local hasPermission = false
    
            if config["panic"].useDiscordRoles then
                local allowedRoles = config["panic"].allowedDiscordRoles
    
                for _, roleId in ipairs(allowedRoles) do
                    if table.contains(playerRoles, roleId) then
                        hasPermission = true
                        break
                    end
                end
    
                if not hasPermission then
                    return
                end
            end
    
            -- Trigger the panic event for all clients
            TriggerClientEvent("ND_Panic:panic", -1, playerCoords, table.concat(args, " "))
        end, false)
    end
    
    -- Utility function to check if a table contains a value
    function table.contains(tbl, value)
        for _, v in pairs(tbl) do
            if v == value then
                return true
            end
        end
        return false
    end
    