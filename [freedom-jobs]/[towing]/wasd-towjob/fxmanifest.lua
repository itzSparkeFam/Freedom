fx_version 'cerulean'
lua54 'yes'
game 'gta5'
name 'wasd-towjob'
author 'WASD'
version '1.0.1'
description 'Fivem Tow Job Script by WASD'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua',
	'shared/init.lua',
}

files {
	'locales/*.json',
	'modules/**/client.lua',
	'modules/bridge/**/client.lua',
	'ui/build/index.html',
	'ui/build/**/*',
}

client_script 'client.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

ui_page 'ui/build/index.html'

dependencies { 'ox_lib' }

escrow_ignore {
	'config.lua',
	'shared/init.lua',
	'modules/**/*.lua',
}

dependency '/assetpacks'