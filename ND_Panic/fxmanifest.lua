-- For support join my discord: https://discord.gg/Z9Mxu72zZ6
author "Andyyy#7666, N1K0#0001, Bear"
description "ND_Panic"
version "0.0.1"

fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_scripts {
    '@ox_lib/init.lua',
	"config.lua"
}

client_script "source/client.lua"
server_script "source/server.lua"

dependency "ND_Core"