config = {
    ["/panic"] = {
        enabled = true,                          -- Enable or disable panic button functionality
        useCustomUI = true,                      -- Toggle between native UI and custom UI
        callTo = { "LSPD", "SAHP", "BCSO" },     -- Departments that receive panic button notifications
        ignoreDepartments = false,               -- If true, all players receive panic button notifications
        blipSprite = 645,                        -- Configurable blip icon
        blipColor = 1,                           -- Configurable blip color
        blipScale = 0.8,                         -- Configurable blip size
        blipFlashInterval = 500,                 -- Configurable blip flash interval
        sound = "panic",                         -- Configurable panic sound name
        soundVolume = 1.0,                       -- Configurable sound volume
        notificationTitle = "~r~Panic Button~r~", -- Configurable notification title with color codes
        notificationSubtitle = "~y~Officer in Distress~y~", -- Configurable notification subtitle with color codes
        notificationIcon = "https://via.placeholder.com/50", -- Custom icon URL
        waypointText = 'Press ~h~[Y]~h~ to set ~g~GPS~g~ waypoint.', -- Configurable text for waypoint
        blipText = "Active Panic-Button: ",     -- Configurable text for the blip
        customUIPath = "nui://ui/index.html" -- Path to the CustomUI HTML
    }
}
