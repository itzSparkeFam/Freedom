fx_version 'cerulean'
lua54 'yes'
game 'gta5'
name 'lation_coke'
author 'iamlation'
version '1.0.4'
description 'An advanced coke resource for FiveM'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/server.lua',
    'config/server.lua',
    'server/*.lua',
}

client_scripts {
    'bridge/client.lua',
    'config/client.lua',
    'client/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config/shared.lua',
    'config/icons.lua',
}

files {
    'stream/*.ytyp',
    'stream/*.ydr',
    'locales/*.json',
    'labs/*.png',
    'labs/*.jpg',
    'labs/*.jpeg'
}

data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'

dependencies {
	'oxmysql',
	'ox_lib',
    'bob74_ipl'
}

ox_libs {
    'locale',
    'math'
}

escrow_ignore {
    'config/*.lua',
    'locales/*.json',
    'client/functions.lua',
    'server/functions.lua',
    'bridge/*.lua'
}
dependency '/assetpacks'