-- For support join my discord: https://thestoicbear.dev/discord
author "Andyyy#7666, N1K0#0001 & Edited by lucas🪐#7921 & TheStoicBear.dev"
description "Stoic-Panic"
version "2..0"

fx_version "cerulean"
game "gta5"
lua54 "yes"
dependencies {
    "ND_Core",
    "interact-sound"
}
shared_scripts  {
    "@ox_lib/init.lua",
	"config.lua"
}
client_scripts {
    "source/client.lua",
    "@Badger-Anticheat/acloader.lua"
} 

server_script "source/server.lua"

files {
    "ui/index.html"       -- HTML file for the UI
}

ui_page "ui/index.html"  -- Define the HTML file as the UI page