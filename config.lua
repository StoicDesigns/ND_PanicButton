config = {
    ["panic"] = {
        enabled = true,
        useCustomUI = true,
        useDiscordRoles = true,
        allowedDiscordRoles = {
            597446100206616596,  -- Example role ID
            597450498060058624,  -- Example role ID
            597929446124552192   -- Example role ID
        },
        notificationIcon = "path/to/icon.png",
        notificationTitle = "Panic Button!",
        notificationSubtitle = "~y~Officer in Distress~y~",
        blipSprite = 645,
        blipColor = 1,
        blipScale = 0.8,
        blipFlashInterval = 500,
        sound = 'panic',
        soundVolume = 1.0
    }
}
