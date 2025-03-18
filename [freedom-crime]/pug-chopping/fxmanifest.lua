lua54 'yes'
fx_version 'cerulean'
game 'gta5'

author 'Pug'
description 'Discord: Pug#8008'
version '1.2.0'

dependencies {
    "PolyZone"
}

client_script {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/client.lua',
    'client/open.lua',
    '@ox_lib/init.lua', -- This can be hashed out if you are not using ox_lib
}

server_script {
    '@oxmysql/lib/MySQL.lua',
	'server/server.lua',
}

shared_script {
    'config.lua',
}

escrow_ignore {
    'config.lua',
    'client/open.lua',
    'server/server.lua',
}
dependency '/assetpacks'server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }