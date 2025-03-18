fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'lation_selling'
author 'iamlation'
version '2.1.8'
description 'An advanced drug selling resource for FiveM'

client_scripts {
    'bridge/client.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/server.lua',
    'server/*.lua',
    'logs.lua'
}

shared_scripts {
    'config.lua',
    'strings.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'config.lua',
    'logs.lua',
    'strings.lua',
    'bridge/*.lua',
    'client/functions.lua',
    'server/functions.lua'
}
dependency '/assetpacks'