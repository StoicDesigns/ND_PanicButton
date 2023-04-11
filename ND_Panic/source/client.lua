NDCore = exports["ND_Core"]:GetCoreObject()

if config["/panic"].enabled then
    RegisterNetEvent("ND_Panic:panic")
    AddEventHandler("ND_Panic:panic", function(coords)
        local character = NDCore.Functions.GetSelectedCharacter()
        if not character then
            return
        end
        for _, department in pairs(config["/panic"].callTo) do
            if character.job == department then
                local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
                local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                SetBlipSprite(blip, 645)
                SetBlipColour(blip, 1)
                SetBlipScale(blip, 0.8)
                SetBlipAsShortRange(blip, true)
                SetBlipFlashes(blip, true)
                SetBlipFlashInterval(blip, 500)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Active Panic-Button: " .. location)
                EndTextCommandSetBlipName(blip)

                -- Play sound on receiver's client
                local soundId = GetSoundId()
                Citizen.CreateThread(function()
                    local soundTimer = GetGameTimer() + 10000 -- 10 seconds
                    while GetGameTimer() < soundTimer do
                        PlaySoundFrontend(soundId, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
                        Citizen.Wait(1000)
                    end
                    ReleaseSoundId(soundId)
                end)

                -- Show notification and press Y to set waypoint on receiver's client
                Citizen.CreateThread(function()
                    Citizen.Wait(2000)
                    local playerPed = GetPlayerPed(-1)
                    local playerName = GetPlayerName(PlayerId())
                    local playerCoords = GetEntityCoords(playerPed)
                    AddTextEntry('ND_PanicButton', 'Location: ' .. location .. "\nPress ~h~[Y]~h~ to set ~g~GPS~g~ waypoint.")
                    SetNotificationTextEntry('ND_PanicButton')
                    SetNotificationMessage('CHAR_CALL911', 'CHAR_CALL911', true, 4, '~r~Panic Button~r~', '~y~Officer in Distress~y~', playerName, playerCoords.x, playerCoords.y, playerCoords.z)
                    DrawNotification(false, true)

                    -- Wait for player to press Y and set GPS waypoint
                    while true do
                        Citizen.Wait(0)
                        if IsControlPressed(0, 246) then -- Y button
                            SetNewWaypoint(coords.x, coords.y)
                            break
                        end
                    end
                end)

                Citizen.Wait(60 * 1000)
                RemoveBlip(blip)
                break
            end
        end
    end)
end
