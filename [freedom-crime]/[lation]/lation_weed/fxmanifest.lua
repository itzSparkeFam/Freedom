fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'lation_weed'
author 'iamlation'
version '3.0.7'
description 'An advanced weed growing resource for FiveM'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/server.lua',
    'logs.lua',
    'server/*.lua'
}

client_scripts {
    'bridge/client.lua',
    'client/*.lua'
}

shared_scripts {
    'config/*.lua',
    '@ox_lib/init.lua'
}

files {
    'stream/*.ytyp',
    'stream/**/*.ydr',
    'locales/*.json'
}

data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'

dependencies {
	'oxmysql',
	'ox_lib'
}

ox_libs {
    'locale',
    'math'
}

escrow_ignore {
    'config/*.lua',
    'logs.lua',
    'locales/*.json',
    'client/functions.lua',
    'server/functions.lua',
    'bridge/*.lua'
}
dependency '/assetpacks'