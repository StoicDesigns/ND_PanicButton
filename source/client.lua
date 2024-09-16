-- Get Discord roles from Badger_Discord_API
local function getDiscordRoles(playerSource)
    local roles = exports.Badger_Discord_API:GetDiscordRoles(playerSource)  -- Fetch Discord roles
    return roles or {}
end

-- Handle panic event
if config["panic"].enabled then
    RegisterNetEvent("ND_Panic:panic")
    AddEventHandler("ND_Panic:panic", function(coords)
        local playerSource = GetPlayerServerId(PlayerId())  -- Get player's server ID
        local playerName = GetPlayerName(PlayerId())  -- Get player's name

        -- Get Discord roles
        local playerRoles = getDiscordRoles(playerSource)
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

        -- Trigger custom UI if enabled
        if config["panic"].useCustomUI then
            -- Get location
            local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))

            -- Trigger the custom UI via NUI message
            SendNUIMessage({
                action = "showPanicNotification",
                icon = config["panic"].notificationIcon, -- Custom icon
                title = config["panic"].notificationTitle,
                subtitle = config["panic"].notificationSubtitle,
                playerName = playerName,
                playerCoords = { x = coords.x, y = coords.y, z = coords.z }
            })
        else
            -- Native notification system (existing logic for blips, sounds, etc.)
            local blipSprite = config["panic"].blipSprite or 645
            local blipColor = config["panic"].blipColor or 1
            local blipScale = config["panic"].blipScale or 0.8
            local blipFlashInterval = config["panic"].blipFlashInterval or 500

            local panicSound = config["panic"].sound or 'panic'
            local soundVolume = config["panic"].soundVolume or 1.0

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

-- Utility function to check if a table contains a value
function table.contains(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end
