shared_script "@ReaperV4/await.lua"
client_script "@ReaperV4/c-bypass.lua"
server_script "@ReaperV4/s-bypass.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kakarot'
description 'Allows players to deliver packages to stores for money while also re-stocking the store'
version '1.2.0'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'config.lua',
	'locales/en.lua',
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
	'client/main.lua',
}

server_scripts {
	'server/main.lua',
}
server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }