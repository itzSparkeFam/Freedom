fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'iamlation'
name 'lation_meth'
description 'An advanced meth crafting resource for FiveM'
version '1.0.11'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/server.lua',
    'server/*.lua',
    'logs.lua',
    'strains.lua'
}

client_scripts {
    'bridge/client.lua',
    'client/*.lua'
}

shared_scripts {
    'config.lua',
    'strings.lua',
    '@ox_lib/init.lua'
}

dependencies {
	'oxmysql',
	'ox_lib',
    'bob74_ipl'
}

files {
    'images/*.png',
    'images/*.jpg',
    'images/*.jpeg',
    'images/*.webp'
}

escrow_ignore {
    'config.lua',
    'strings.lua',
    'logs.lua',
    'strains.lua',
    'bridge/*.lua',
    'client/functions.lua',
    'server/functions.lua'
}
dependency '/assetpacks'