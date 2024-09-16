NDCore = exports["ND_Core"]:GetCoreObject()

if config["/panic"].enabled then
    RegisterCommand("panic", function(source, args, rawCommand)
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)
        TriggerClientEvent("ND_Panic:panic", -1, playerCoords, table.concat(args, " "))
    end, false)
end
