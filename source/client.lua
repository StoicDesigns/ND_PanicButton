NDCore = exports["ND_Core"]:GetCoreObject()

if config["/panic"].enabled then
    RegisterNetEvent("ND_Panic:panic")
    AddEventHandler("ND_Panic:panic", function(coords)
        local character = NDCore.Functions.GetSelectedCharacter()
        if not character then
            return
        end

        local ignoreDepartments = config["/panic"].ignoreDepartments

        -- Department check
        if ignoreDepartments then
            -- Allow all to receive panic notifications
        else
            -- Check if the player's department matches allowed departments
            local jobMatched = false
            for _, department in pairs(config["/panic"].callTo) do
                if character.job == department then
                    jobMatched = true
                    break
                end
            end
            
            if not jobMatched then
                return
            end
        end

        -- Trigger custom UI if enabled
        if config["/panic"].useCustomUI then
            -- Get location
            local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
            local playerName = GetPlayerName(PlayerId())

            -- Trigger the custom UI via NUI message
            SendNUIMessage({
                action = "showPanicNotification",
                icon = config["/panic"].notificationIcon, -- Custom icon
                title = config["/panic"].notificationTitle,
                subtitle = config["/panic"].notificationSubtitle,
                playerName = playerName,
                playerCoords = { x = coords.x, y = coords.y, z = coords.z }
            })
        else
            -- Native notification system (existing logic for blips, sounds, etc.)
            local blipSprite = config["/panic"].blipSprite or 645
            local blipColor = config["/panic"].blipColor or 1
            local blipScale = config["/panic"].blipScale or 0.8
            local blipFlashInterval = config["/panic"].blipFlashInterval or 500

            local panicSound = config["/panic"].sound or 'panic'
            local soundVolume = config["/panic"].soundVolume or 1.0

            local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))

            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(blip, blipSprite)
            SetBlipColour(blip, blipColor)
            SetBlipScale(blip, blipScale)
            SetBlipAsShortRange(blip, true)
            SetBlipFlashes(blip, true)
            SetBlipFlashInterval(blip, blipFlashInterval)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Active Panic-Button: " .. location)
            EndTextCommandSetBlipName(blip)

            TriggerEvent('InteractSound_CL:PlayOnOne', panicSound, soundVolume)
        end
    end)
end
