server_script "JQ.lua"
client_script "JQ.lua"
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version      '3.23.0'

author 'Baguscodestudio'
description 'License manager for jobs'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/images/*.png',
    'html/assets/*.js',
    'html/assets/*.css',
    'modules/**/*.lua'
}

shared_script { '@ox_lib/init.lua', 'init.lua' }

client_scripts {
    'config/config.lua',
    'config/screenshot.lua',
    'config/locales.lua',
    'config/manager.lua',
    'config/licenses.lua',
    'config/badges.lua',
    'client/target.lua',
    'client/functions.lua',
    'client/events.lua',
    'client/main.lua',
    'client/compability.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'utils.lua',
    'config/config.lua',
    'config/locales.lua',
    'config/manager.lua',
    'config/licenses.lua',
    'config/badges.lua',
    'server/functions.lua',
    'server/events.lua',
    'server/main.lua',
    'server/convert.lua',
    'server/compability.lua',
    'server/init.lua',
    'server/screenshot.js'
}

escrow_ignore {
    'utils.lua',
    'config/*.lua',
    'server/functions.lua',
    'server/events.lua',
    'server/convert.lua',
    'client/functions.lua',
    'client/events.lua',
    'modules/**/*.lua'
}

dependencies {
    'yarn',
    'screenshot-basic'
}

provide 'esx_license'

dependency '/assetpacks'