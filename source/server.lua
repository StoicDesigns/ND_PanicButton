NDCore = exports["ND_Core"]:GetCoreObject()

if config["/panic"].enabled then
    RegisterCommand("panic", function(source, args, rawCommand)
        local player = NDCore.getPlayer(source)  -- Retrieve player data
        if player then
            local playerCoords = player.coords  -- Assuming player has `coords` field
            TriggerClientEvent("ND_Panic:panic", -1, playerCoords, table.concat(args, " "))
        end
    end, false)
end
