NDCore = exports["ND_Core"]:GetCoreObject()

if config["/panic"].enabled then
    RegisterCommand("panic", function(source, args, rawCommand)
        local player = source
        TriggerClientEvent("ND_Panic:panic", -1, GetEntityCoords(GetPlayerPed(player)), table.concat(args, " "))
    end, false)
end